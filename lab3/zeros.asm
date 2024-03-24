# zeros program in asm
.text 
main:

li a7, 4	# load 4 into register 7; ecall will print string a0
la a0, welcome	# load data "welcome" into a0
ecall		# "Welcome to the CountOnes program.\n"

li t5, 2670	# designate "n" user input value to t5

Loop:	# Loop from "please enter number..." to "continue..."

li a7, 4	# load 4 into register 7; ecall will print string a0
la a0, enternum	# load data "enternum" into a0
ecall		# "\nPlease enter a number: "

li a7, 5	# load 5 into register 7; ecall will take user input and store in a0
ecall		# user types in value to be stored in a0
mv t0, a0	# move integer stored in a0 to t0

li a7, 4	# load 4 into register 7; ecall will print string a0
la a0, leadingzero	# load data "leadingzero" into a0
ecall		# "The number of leading zeros is: "

addi t1, zero, 31	# t1 is the amount of times we shift the bit in
addi t2, zero, 0	# t2 is the leading zeros counted
addi t3, zero, 1	# t3 = 1, to help us test if there is a "1" bit on the right side

leadzerocalc: 	# loop to calculate the leading zeros in the number
srl t4, t0, t1		# shift user input t0 right (logical) by value t1
beq t4, t3, MoreLoop	# if the leading number is 1, then break out of loop
sub t1, t1, t3		# decrement shift right value by 1
addi t2, t2, 1		# add 1 to leading zeros counted
j leadzerocalc		# repeat the loop to check the next leading number

MoreLoop:	# Continuation of loop from "please enter number..." to "continue..."

li a7, 1	# load 1 into register a7 (print an integer a0)
mv a0, t2	# move iinteger stored in t2 (leading zeros counted) to a0
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
j Loop			# if user input is not "n"

end:
li a7, 10	# load 10 into register 7; ecall will end the program
ecall	# end the program

.data
padding:	# reserve space for data segment
.space 81
paddingsize:
.word 80
welcome:	# string
.string "Welcome to the Zeros program.\n"
enternum:	# string
.string "\nPlease enter a number: "
leadingzero:	# string
.string "The number of leading zeros is: "
continue:	# string
.string "\nContinue? (y/n)?: "
no:
.string "n\n"
