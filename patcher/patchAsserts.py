from pwn import *
import sys, subprocess

if(len(sys.argv) != 3):
	print "Usage: python "+sys.argv[0]+" <binaryName> <resulting binary name>"
	print "\tExample: ", sys.argv[0], " something_temp example"
	exit(1)

fld_instrs = []
expected_addresses = []
expected_hashes = []

orig_name = sys.argv[1]
new_name = sys.argv[2]
e = ELF(orig_name)

result = subprocess.check_output(["gdb", orig_name, "-x", "/home/sip/sip-oblivious-hashing/assertions/gdb_script.txt"]).decode("utf-8")
lines = result.splitlines()

print result

for line in lines:
	print line
	if line.startswith("#1"):
		words = line.split()
		fld_instrs.append(int(words[1], 16) - 20)
	if line.startswith("$"):
		words = line.split()
		expected_hashes.append(int(words[2]))

#print "Instructions at:", [hex(i) for i in fld_instrs]
#print "Expected hashes:", expected_hashes

i = 0
for pos in fld_instrs:
#	print 'before ', e.disasm(pos,10)
	e.write(pos+2, struct.pack("<q", expected_hashes[i]))
	i = i + 1
	dis = e.disasm(pos, 10)
#	print 'after ', dis

e.save(new_name)
