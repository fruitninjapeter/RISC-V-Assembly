.text
.globl printint
.globl printstring
.globl readchar
.globl readint
.globl exit

printint:	# printint (int)
li a7, 1	# load 1 into a7
ecall		# prints int a0
ret

printstring:	# printstring (address)
li a7, 4	# load 4 into a7
ecall		# prints string a0
ret

readchar:	# int readchar ()
li a7, 12	# load 12 into a7, which is readchar
ecall		# char a0 = user input
ret

readint:	# int readint ()
li a7, 5	# service call '5' for readint
ecall		# int a0 = user input
ret

exit:	# exit ()
li a7, 10
ecall