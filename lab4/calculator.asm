.text
.global main
.global mainloop
.global maincont
.global opsuccess
.global falseop
.global addjump
.global subjump
.global multjump
.global divjump
.global andjump
.global orjump
.global xorjump

main:

la a0, welcome		# load data "welcome" into a0
jal printstring		# jump to printstring subroutine; "Welcome to the Calculator program.\n"
la a0, info		# load data "info" into a0
jal printstring		# "Operations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor\n"

li s0, 110	# "n", don't continue
li s1, 1	# operation 1: add
li s2, 2	# operation 2: subtract
li s3, 3	# operation 3: multiply
li s4, 4	# operation 4: divide
li s5, 5	# operation 5: and
li s6, 6	# operation 6: or
li s7, 7	# operation 7: xor

mainloop:

la a0, performed	# load data "performed" into a0
jal printstring		# "Number of operations performed: "

add a0, zero, t0	# load number of operations performed t0 into a0
jal printint		# prints int a0

la a0, enternum		# load data "enternum" into a0
jal printstring		# "Enter number: "
jal readint		# reads user input of an int
mv a1, a0		# moves int a0 to a1

la a0, anothernum	# load data "anothernum" into a0
jal printstring		# "Enter second number: "
jal readint		# reads user input of an int a0
mv a2, a0		# moves int a0 to a2

la a0, selectop		# load data "selectop" into a0
jal printstring		# "Select operation: "
jal readint		# reads user input of an int a0

blt a0, s1, falseop	# if a0 < 1, jumps to false operation function
bgt a0, s7, falseop	# if a0 > 7, jumps to false operation function
beq a0, s1, addjump	# if a0 = 1 = s1, jumps to add helper function (to jump and link to subroutine in operations file)
beq a0, s2, subjump	# if a0 = 2 = s2, jumps to sub helper function
beq a0, s3, multjump	# if a0 = 3 = s3, jumps to mult helper function
beq a0, s4, divjump	# if a0 = 4 = s4, jumps to div helper function
beq a0, s5, andjump	# if a0 = 5 = s5, jumps to and helper function
beq a0, s6, orjump	# if a0 = 6 = s6, jumps to or helper function
beq a0, s7, xorjump	# if a0 = 7 = s7, jumps to xor helper function

opsuccess:	# operation success
	mv a3, a0		# move answer a0 to a3
	la a0, result		# load data "result" into a0
	jal printstring		# "Result: "
	mv a0, a3		# move answer a3 to a0
	jal printint		# print int a0
	j maincont		# jump to continuation of main loop
falseop:	# invalid operation
	la a0, result		# load data "result" into a0
	jal printstring		# "Result: "
	la a0, invalid		# load data "invalid" into a0
	jal printstring		# "Invalid Operation"
	j maincont		# jump to continuation of main loop

maincont:

addi t0, t0, 1	# increment operations performed t0 by 1

la a0, continue		# load data "continue" into a0
jal printstring		# "Continue (y/n)?: "
jal readchar		# read user character input
bne a0, s0, mainloop	# If user didn't input 'n", loop back to do another operation

la a0, performed	# load data "performed" into a0
jal printstring		# "Number of operations performed: "
add a0, zero, t0	# load number of operations performed t0 into a0
jal printint		# prints int a0

la a0, exiting		# load data "exiting" into a0
jal printstring		# "Exiting"
jal exit		# jumps to exit subroutine

addjump:	# jump to add operation
	jal addnums
	j opsuccess
subjump:	# jump to sub operation
	jal subnums
	j opsuccess
multjump:	# jump to mult operation
	jal multnums
	j opsuccess
divjump:	# jump to div operation
	jal divnums
	j opsuccess
andjump:	# jump to and operation
	jal andnums
	j opsuccess
orjump:		# jump to or operation
	jal ornums
	j opsuccess
xorjump:	# jump to xor operation
	jal xornums
	j opsuccess

.data
welcome: .string "Welcome to the Calculator program.\n"
info: .string "Operations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor"
performed: .string "\n\nNumber of operations performed: "
enternum: .string "\nEnter number: "
anothernum: .string "Enter second number: "
selectop: .string "Select operation: "
result: .string "Result: "
invalid: .string "Invalid Operation"
continue: .string "\nContinue (y/n)?: "
exiting: .string "\nExiting"
