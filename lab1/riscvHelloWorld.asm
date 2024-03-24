.text 
main:	# label to indicate a position in code

li a7, 4	# load immediate; put 4 into register a7

la a0, greeting	# load address of greeting into a0
ecall	# environment call (call the OS to print a string)

.data
greeting:
.string "Hello World!"