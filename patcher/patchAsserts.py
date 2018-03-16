from pwn import *
import sys, subprocess
import argparse



def patch_binary(orig_name, new_name,debug):
    patch_map ={}
    fld_instrs = []
    expected_addresses = []
    expected_hashes = []
    placeholders = []
    #orig_name = sys.argv[1]
    #new_name = sys.argv[2]
    e = ELF(orig_name)
    result = subprocess.check_output(["gdb", orig_name, "-x", "/home/sip/sip-oblivious-hashing/assertions/gdb_script.txt"]).decode("utf-8")
    lines = result.splitlines()
    print result
    if "segmentation fault" in result.lower() or "bus error" in result.lower():
        print "GDB patcher segmentation fault detected..."
        exit(1)
    isThirdLine = False
    for line in lines:
        if debug:
            print line
        if line.startswith("#1"):
            words = line.split()

            fld_instrs.append(int(words[1], 16) - 20)
        if line.startswith("$"):
            words = line.split()
            if isThirdLine:
                placeholders.append(words[2])
                isThirdLine = False
            else:
                expected_hashes.append(int(words[2]))
                isThirdLine = True


    #print "Instructions at:", [hex(i) for i in fld_instrs]
    #print "Expected hashes:", expected_hashes
    i = 0
    for pos in fld_instrs:
        expected = expected_hashes[i]
        if pos in patch_map.keys():
            if expected != patch_map[pos]:
                print 'Err. Patching the same address '+ str(hex(pos)) +' placeholder['+str(placeholders[i])+'] with two different expected hashes'
                exit(1)
        if debug:
            print str(i)+' Patching '+str(hex(pos))+" with "+str(expected)+ ' placeholder:'+str(placeholders[i]) 
            print 'before ', e.disasm(pos,10)
        patch_map[pos] = expected
        
	e.write(pos+2, struct.pack("<q", expected_hashes[i]))
	i = i + 1
	dis = e.disasm(pos, 10)
        if debug:
            print 'after ', dis

    e.save(new_name)
    return i;


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-b',action='store', dest='binary', help='Binary name to patch using GDB')
    parser.add_argument('-n',action='store', dest='new_binary', help='Output new binary name after patching')
    parser.add_argument('-a',action='store', dest='assert_count', help='Number of patches to be verified at the end of the process',required=False,type=int)
    parser.add_argument('-d',action='store', dest='debug', help='Print debug messages',required=False,type=bool, default=False)
    parser.add_argument('-s',action='store', dest='oh_stats_file', help='OH stats file to get the number of patches to be verified at the end of the process',required=False)


    results = parser.parse_args()
    count_patched = patch_binary(results.binary,results.new_binary, results.debug)
    print "Patched:",count_patched," in ",results.new_binary," saved as:",results.new_binary
    assert_count =0
    if results.oh_stats_file:
        import json
        from pprint import pprint 
        oh_stats =json.load(open(results.oh_stats_file))
        assert_count = int(oh_stats["numberOfAssertCalls"])
    else: 
        assert_count = results.assert_count

    if assert_count>0:
        #Verify that the number of patches is equal to the number of asserts in the binary
        if count_patched != assert_count:
            print 'WARNING. Some asserts are not patched! Patched=',count_patched," Asserts=",assert_count
            #exit(1)
        else:
            print 'Info. Patched=',count_patched," Asserts=",assert_count

if __name__ == "__main__":
    main()
