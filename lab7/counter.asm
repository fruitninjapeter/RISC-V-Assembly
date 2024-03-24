.text

main:

li s0, 32	# " ", spacebar char to increment
li s1, 113	# "q" char to quit program

li s2, 0xFFFF0011	# set s2 to address of left LED
li s3, 0xFFFF0010	# set s3 to address of right LED

add s4, zero, sp	# set s4 to initial stack pointer location

li a1, 0		# tens counter
li s5, 10		# set s5 as 10 for tens check to reset upon reaching 100

addi sp, sp, -10	# push stack by 10
li a0, 0x3F	# byte value of "0" display
sb a0, 0(sp)
li a0, 0x06	# "1" display
sb a0, 1(sp)
li a0, 0x5B	# "2" display
sb a0, 2(sp)
li a0, 0x4F	# "3" display
sb a0, 3(sp)
li a0, 0x66	# "4" display
sb a0, 4(sp)
li a0, 0x6D	# "5" display
sb a0, 5(sp)
li a0, 0x7D	# "6" display
sb a0, 6(sp)
li a0, 0x07	# "7" display
sb a0, 7(sp)
li a0, 0x7F	# "8" display
sb a0, 8(sp)
li a0, 0x6F	# "9" display
sb a0, 9(sp)

lb a0, 0(sp)	# load "0" display
sb a0, (s2)	# initialize "0" on right LED
lb a0, 0(sp)	# load "0" display
sb a0, (s3)	# initialize "0" on right LED

input:

li a7, 12	# load 12 into a7, for readchar
ecall		
beq a0, s0, increment	# if char is " " (spacebar, increment the number
beq a0, s1, exit	# else move down to exit if char is "q"
j input		# nothing significant happens for all other characters; jump to input again

increment:	# increment number by 1
addi sp, sp, 1	# pop stack by 1
beq sp, s4, incrementten	# if stack is 10, move to incrementten function
lb a0, 0(sp)	# load byte value of display from current stack pointer location
sb a0, (s3)	# set right LED to display number
j input

incrementten:	# increment left LED number by 1
addi sp, sp, -10	# push stack down by 10 again
lb a0, 0(sp)	# load byte value of display
sb a0, (s3)	# set right LED to display number
addi a1, a1, 1		# increment tens value by 1
beq a1, s5, reset	# if tens value is 10, then go to reset function
add sp, sp, a1	# add stack pointer by current tens value
lb a0, 0(sp)	# load byte value of display
sb a0, (s2)	# set left LED to display number
sub sp, sp, a1	# restore previous stack pointer value
j input

reset:	# resets the number to "00" upon reaching 100
lb a0, 0(sp)	# loads "0" display
sb a0, (s2)	# set left LED to display "0"
sb a0, (s3)	# set right LED to display "0"
li a1, 0	# reset the tens value to 0
j input

exit:	# exit program if user inputs "q"
li a7, 10
ecall