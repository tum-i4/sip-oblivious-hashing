from pwn import *
import sys, subprocess
import argparse
import mmap
import re
from shutil import copyfile
def match_placeholders(console_reads):
    address = r'.*? \#\d+ [ ]+ (0(?:[a-z][a-z]*[0-9]+[a-z0-9]*)) .*? in [ ]+ ((?:[a-z][a-z0-9_]*)) .*?\n'
    computed = r'\$\d+ .*? (\d+) .*?\n'
    placeholder = r'\$\d+ .*? (\d+) .*?\n'
    print 'Begin reg compile'
    rg = re.compile(address+computed+placeholder,re.IGNORECASE|re.MULTILINE|re.VERBOSE|re.DOTALL)
    print "Begin find all"
    matchobj = rg.findall(console_reads)
    print "End find all"
    return matchobj

def patch_binary(orig_name, new_name,debug, args, script):
    patch_map ={}
    expected_hashes={}
    #e = ELF(orig_name)
    #result = subprocess.check_output(["gdb", orig_name, "-x", "/home/anahitik/SIP/sip-oblivious-hashing/assertions/gdb_script.txt"]).decode("utf-8")
    #cmd = ["gdb", orig_name, "-x", "/home/sip/sip-oblivious-hashing/assertions/gdb_script.txt"]
    cmd = ["gdb", orig_name, "-x", script]
    if args !='':
        print 'Args provided ', args
        args_splitted = args.split();
        cmd = ["gdb","-x", script,'--args',orig_name]
        cmd.extend(args_splitted)
    print cmd
    #result = subprocess.check_output(cmd).decode("utf-8")
    p = subprocess.Popen(cmd, stderr =None,stdout=subprocess.PIPE)
    result, err = p.communicate();
    print "gdb ran. Parsing results"
    line_print = False
    placeholder_results = ''
    pre_line = ''
    for line in result.splitlines():
        if line == 'BEGIN-PLACEHOLDER':
            placeholder_results += pre_line+"\n"
            line_print = True
        elif line == 'END-PLACEHOLDER':
            line_print = False
        elif line_print:
            #print line
            placeholder_results+=line+"\n"
        pre_line = line
    

    if debug:
        print placeholder_results    
    print "Begin matching placeholders"
    tuples = match_placeholders(placeholder_results)
    if len(tuples) == 0 :
        print "NO PLACEHOLDERS WERE MATCHED!"
    print "End matching placeholders"
    if debug:
        print tuples
    for info in tuples:
        address = info[0]
        function = info[1]
        computed = int(info[2])
        placeholder = info[3]
        fld_instr = int(address, 16) - 20
        expected_hashes[placeholder] = (computed, fld_instr, function)
    #exit(1)
    #lines = result.splitlines()
    #print result
    if "segmentation fault" in result.lower() or "bus error" in result.lower():
        print "GDB patcher segmentation fault detected..."
        exit(1)
    #hasFirstLine = False
    #isThirdLine = False
    #placeholder=""
    #expected_hash = 0

    #for line in lines:
     #   if debug:
      #      print line
       # if line.startswith("#1"):
        #    words = line.split()
         #   fld_instr = int(words[1], 16) - 20
          #  function = words[3]
           # hasFirstLine = True
       # if hasFirstLine and line.startswith("$"):
        #    words = line.split()
         #   if isThirdLine:
          #      placeholder = words[2]
           #     hasFirstLine = isThirdLine = False
            #    expected_hashes[placeholder] = (expected_hash, fld_instr, function)
           # else:
            #    try:
	#	    expected_hash = int(words[2])
         #           isThirdLine = True
	#	except TypeError:
	#	    print 'ERR. Type error expected hash reading from a bad line {}'.format(line)
         #           break
        #else:
         #   hasFirstLine = False

    #print expected_hashes
    #exit(1)
    #e.save(new_name)
    copyfile(orig_name,new_name);
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
    print "patching placeholders"
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
            if str(placeholder).strip() == str(expected_hash).strip():
                #when palceholder is the same with the expected hash we fall into an endless loop
                if debug:
                    print 'Placeholder [{}] with the same value as the expected hash [{}] is being skipped'.format(placeholder,expected_hash)
            else:
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
    parser.add_argument('-g',action='store', dest='args', required= False, type=str,default='',help='Running arguments to the program to patch')
    parser.add_argument('-p', action='store', dest='script', required= False, type=str,
                        default='/home/sip/sip-oblivious-hashing/assertions/gdb_script.txt',
                        #'/home/anahitik/SIP/sip-oblivious-hashing/assertions/gdb_script.txt',
                        help='gdb script to use when performing patching')

    results = parser.parse_args()
    placeholders = patch_binary(results.binary,results.new_binary, results.debug,results.args, results.script)
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
