.text
.globl factorial
.globl recur

factorial:

	bgt a0, zero, recur
	li a0, 1
	ret

recur:
	addi sp, sp, -16
	sw ra, 0(sp)
	sw a0, 4(sp)
	addi a0, a0, -1
	jal factorial
	lw a1, 4(sp)
	mul a0, a0, a1
	lw ra, 0(sp)
	addi sp, sp, 16
	ret