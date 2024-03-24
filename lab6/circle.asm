.text
.globl circle
.globl returnhelpe
.global circleplot

circle:	# (xc, yc, r) = (a0, a1, a2)

addi sp, sp, -28	# move sp down to be able to store 7 words
li a3, 0	# load x = 0
sw a3, 0(sp)	# stack slot 1 is x = 0
sw a2, 4(sp)	# stack slot 2 is y = r
add a4, a2, a2	# 2*r
li a3, 3	
sub a3, a3, a2	# a3 = g = 3 - 2*r
sw a3, 8(sp)	# stack slot 3 is g
li a3, 10	
add a4, a4, a4	# 2r + 2r = 4*r
sub a3, a3, a4	# a3 = diagonalInc = 10 - 4*r
sw a3, 12(sp)	# stack slot 4 is diagonalInc
li a3, 6	# rightInc = 6
sw a3, 16(sp)	# stack slot 5 is rightInc
sw a0, 20(sp)	# stack slot 6 is xc
sw a1, 24(sp)	# stack slot 7 is yc

circleplot:

lw a2, 20(sp)	# a2 = xc
lw a3, 24(sp)	# a3 = yc
lw a5, 0(sp)	# a5 = x
lw a6, 4(sp)	# a6 = y
# plot (xc+x, yc+y)
lw a2, 20(sp)	# a2 = xc
add a1, a2, a5
add a0, a3, a6
jal plot
# plot (xc+x, yc-y)
lw a2, 20(sp)	# a2 = xc
add a1, a2, a5
sub a0, a3, a6
jal plot
# plot (xc-x, yc+y)
lw a2, 20(sp)	# a2 = xc
sub a1, a2, a5
add a0, a3, a6
jal plot
# plot (xc-x, yc-y)
lw a2, 20(sp)	# a2 = xc
sub a1, a2, a5
sub a0, a3, a6
jal plot
# plot (xc+y, yc+x)
lw a2, 20(sp)	# a2 = xc
add a1, a2, a5
add a0, a3, a5
jal plot
# plot (xc+y, yc-x)
lw a2, 20(sp)	# a2 = xc
add a1, a2, a6
sub a0, a3, a5
jal plot
# plot (xc-y, yc+x)
lw a2, 20(sp)	# a2 = xc
sub a1, a2, a6
add a0, a3, a5
jal plot
# plot (xc-y, yc-x)
lw a2, 20(sp)	# a2 = xc
sub a1, a2, a6
sub a0, a3, a5
jal plot

lw a0, 8(sp)	# load g into a0
lw a1, 16(sp)	# load rightInc into a1
bge a0, zero, gpositive		# if g >= 0, jump to gpositive function, else move down
add a0, a0, a1	# g = g + rightInc
sw a0, 8(sp)
lw a2, 12(sp)	# diagonalInc = diagonalInc + 4
addi a2, a2, 4
sw a2, 12(sp)
j whiletest

gpositive:

lw a2, 12(sp)	# g = g + diagonalInc
add a0, a0, a2
sw a0, 8(sp)
addi a2, a2, 8	# diagonalInc = diagonalInc + 8
sw a2, 12(sp)
addi a6, a6, -1	# y = y - 1
sw a6, 4(sp)

j whiletest

whiletest:

addi a1, a1, 4	# rightInc = rightInc + 4
sw a1, 16(sp)
addi a5, a5, 1	# x = x + 1
sw a5, 0(sp)

bgt a5, a6, returnhelpe
j circleplot

returnhelpe:
ret
