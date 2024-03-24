.text
.globl printstring
.globl printchar
.globl readchar
.globl exit

printstring:
li a7, 4	# load 4 (printstring ecall) into a7
ecall		# print string a0
ret		# Put value of ra into PC (program counter), returns you to instance in 'ra'

printchar:
li a7, 11	# load 11 (printchar ecall) into a7
ecall		# print char a0
ret		# Put value of ra into PC (program counter) 

readchar:
li a7, 12	# load 12 (readchar ecall) into a7
ecall		# read user input char into a0
ret		# Put value of ra into PC (program counter) 

exit:
li a7, 10	# load 10 (exit ecall) into a7
ecall