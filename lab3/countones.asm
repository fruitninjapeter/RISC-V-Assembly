# countones program in asm
.text 
main:

li a7, 4	# load 4 into register 7; ecall will print string a0
la a0, welcome	# load data "welcome" into a0
ecall		# "Welcome to the CountOnes program.\n"

lw t5, no		# designate "n" user input value to t5
addi a1, zero, 32	# a1 = amount of bits in an address

Loop:		# Loop from "please enter number..." to "continue..."

li a7, 4	# load 4 into register 7; ecall will print string a0
la a0, enternum	# load data "enternum" into a0
ecall		# "\nPlease enter a number: "

li a7, 5	# load 5 into register 7; ecall will take user input and store in a0
ecall		# user types in value to be stored in a0
mv t0, a0	# move integer stored in a0 to t0

li a7, 4	# load 4 into register 7; ecall will print string a0
la a0, setbits	# load data "setbits" into a0
ecall		# "The number of bits set is: "

addi t1, zero, 0	# t1 is the loop counter
addi t2, zero, 0	# t2 is the bits counted
addi t3, zero, 1	# t3 = 1, to help us test if there is a "1" bit on the right side

bitcount:	# Counting the bits process
bge t1, a1, MoreLoop	# stop counting bits if we counted every bit
and t4, t0, t3		# test if there is a 1 on the right side, then t4 = 1
beq t4, t3, increment	# if there is a 1 bit on t0, then increment the bits counted

bitcountmore:
srli t0, t0, 1	# shift t0 right 1 time
addi t1, t1, 1	# add 1 to loop counter
jal bitcount	# jump to bitcount

MoreLoop:	# Continuation of loop from "please enter number..." to "continue..."

li a7, 1	# load 1 into register a7 (print an integer a0)
mv a0, t2	# move integer stored in t2 (bits counted) to a0
ecall		# prints the integer a0 as a string

li a7, 4	# load 4 into register 7; ecall will print string a0
la a0, continue	# load address of string "continue" into a0
ecall		# "\nContinue? (y/n)?: "

li a7, 8	# load 8 into register 7; ecall will take in string user input
la a0, padding
lw a1, paddingsize
ecall		# take in string user input
lw t6, padding
beq t6, t5, end		# if user input is "n"
jal Loop			# if user input is not "n"

increment:	# increment +1 on bits counted
addi t2, t2, 1	# +1 on bits counted
jal bitcountmore	# jump back to bitcount loop

end:
li a7, 10	# load 10 into register 7; ecall will end the program
ecall	# end the program

.data
padding:	# reserve space for data segment
.space 81
paddingsize:
.word 80
welcome:	# string
.string "Welcome to the CountOnes program.\n"
enternum:	# string
.string "\nPlease enter a number: "
setbits:	# string
.string "The number of bits set is: "
continue:	# string
.string "\nContinue? (y/n)?: "
no:	# string
.string "n\n"
