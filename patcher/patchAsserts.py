from pwn import *
import sys, subprocess
import argparse
import mmap
def patch_binary(orig_name, new_name,debug):
    patch_map ={}
    expected_hashes={}
    e = ELF(orig_name)
    #result = subprocess.check_output(["gdb", orig_name, "-x", "/home/anahitik/SIP/sip-oblivious-hashing/assertions/gdb_script.txt"]).decode("utf-8")
    result = subprocess.check_output(["gdb", orig_name, "-x", "/home/sip/sip-oblivious-hashing/assertions/gdb_script.txt"]).decode("utf-8")
    lines = result.splitlines()
    print result
    if "segmentation fault" in result.lower() or "bus error" in result.lower():
        print "GDB patcher segmentation fault detected..."
        exit(1)
    isThirdLine = False
    placeholder=""
    expected_hash = 0

    for line in lines:
        if debug:
            print line
        if line.startswith("#1"):
            words = line.split()
            fld_instr = int(words[1], 16) - 20
            function = words[3]
        if line.startswith("$"):
            words = line.split()
            if isThirdLine:
                placeholder = words[2]
                isThirdLine = False
                expected_hashes[placeholder] = (expected_hash, fld_instr, function)
            else:
                expected_hash = int(words[2])
                isThirdLine = True


    e.save(new_name)
    return expected_hashes

def find_placeholder(mm, search_bytes):
    addr = mm.find(search_bytes)
    if addr == -1:
        mm.seek(0)
    addr = mm.find(search_bytes)
    return addr

def patch_address(mm, addr, patch_value):
    mm.seek(addr,os.SEEK_SET)
    mm.write(patch_value)
def patch_placeholders(filename, placeholders, debug):
    with open(filename, 'r+b') as f:
        mm = mmap.mmap(f.fileno(), 0)
        patch_count = 0
        for placeholder in placeholders:
            expected_hash = placeholders[placeholder][0]
            if debug:
                print 'Seeking to placeholder ' + placeholder + ' with expected hash ' + str(expected_hash)
            search_bytes = struct.pack("<q", long(placeholder))
            address =0
            patch_value = struct.pack("<q", expected_hash)
            if debug:
                print 'patch value ' + bytes(patch_value)
            address = find_placeholder(mm, search_bytes)
            if address == -1:
                print str(placeholder) + ' placeholder not found'
            else :
                patch_count = patch_count + 1
            while address!=-1:
                if debug:
                    print 'Found placeholder '+placeholder+' at ' + hex(address) + ' trying to patch it with ' + str(expected_hash)
                patch_address(mm,address,patch_value)
                address = find_placeholder(mm, search_bytes)
        return patch_count

def get_function_info(file_name, function_name):
	import r2pipe
	r2 = r2pipe.open(file_name)
	#find addresses and sizes of all functions
	r2.cmd("aa")
	function_list = r2.cmdj("aflj")
	found_func = filter(lambda function:  function['name'] == 'sym.'+function_name,function_list)
	if len(found_func)>0:
                address = r2.cmd("?p "+str(found_func[0]['offset']))
		return int(address,16), found_func[0]['size']
	return -1,-1
def patch_block(file_name,address, size):
    nop_list = []
    for i in range(size-1):
        nop_list.append(0x90)
    nop_bytes = struct.pack('B'*len(nop_list),*nop_list)
    with open(file_name, 'r+b') as f:
        mm = mmap.mmap(f.fileno(), 0)
        mm.seek(address,os.SEEK_SET)
        mm.write(nop_bytes)
def patch_function(file_name):
    function_name = "oh_path_functions"
    #find the address and size of the function in the binary
    address, size = get_function_info(file_name,function_name)
    print " oh_path_functions @"+hex(address),"  length:", str(size) 
    if size>1:
        patch_block(file_name,address, size)
    else:
        print 'No functions to NOP'
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-b',action='store', dest='binary', help='Binary name to patch using GDB')
    parser.add_argument('-n',action='store', dest='new_binary', help='Output new binary name after patching')
    parser.add_argument('-a',action='store', dest='assert_count', help='Number of patches to be verified at the end of the process',required=False,type=int)
    parser.add_argument('-d',action='store', dest='debug', help='Print debug messages',required=False,type=bool, default=False)
    parser.add_argument('-s',action='store', dest='oh_stats_file', help='OH stats file to get the number of patches to be verified at the end of the process',required=False)


    results = parser.parse_args()
    placeholders = patch_binary(results.binary,results.new_binary, results.debug)
    count_patched = patch_placeholders(results.new_binary,placeholders, results.debug)
    print "Patched:",count_patched," in ",results.new_binary," saved as:",results.new_binary
    for placeholder in placeholders:
        print 'Placeholder ' + str(placeholder) + ' expected has ' + hex(placeholders[placeholder][0]) + ' address ' + hex(placeholders[placeholder][1]) + ' function ' + placeholders[placeholder][2]
    assert_count =0
    if results.oh_stats_file:
        import json
        from pprint import pprint 
        oh_stats =json.load(open(results.oh_stats_file))
        assert_count = int(oh_stats["numberOfAssertCalls"])
        assert_count = assert_count + int(oh_stats["numberOfShortRangeAssertCalls"])
    else: 
        assert_count = results.assert_count

    if assert_count>0:
        #Verify that the number of patches is equal to the number of asserts in the binary
        if count_patched != assert_count:
            print 'WARNING. Some asserts are not patched! Patched=',count_patched," Asserts=",assert_count
            #exit(1)
        else:
            print 'Info. Patched=',count_patched," Asserts=",assert_count

    ##NOP oh_path_functions
    patch_function(results.new_binary)
if __name__ == "__main__":
    main()
