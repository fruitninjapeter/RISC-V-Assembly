.text
.global line
.global returnhelp
.global lineplot

line:	# (x0, y0, x1, y1) = (a0, a1, a2, a3)

addi sp, sp, -16	# move to stack 1
sw a0, 0(sp)	# x0 in stack 1 slot 1
sw a1, 4(sp)	# y0 in stack 1 slot 2
sw a2, 8(sp)	# x1 in stack 1 slot 3
sw a3, 12(sp)	# y1 in stack 1 slot 4

sub a0, a2, a0	# a0 = x1 - x0
jal abs		# a0 = abs(x1 - x0)
add a2, a0, zero	# now a2 = abs(x1 - x0)
sub a0, a3, a1	# a0 = y1 - y0
jal abs		# a0 = abs(y1 - y0)
bgt a0, a2, setst 	# if abs(y1 - y0) > abs(x1 - x0) { st = 1; } else { st = 0; }
li a4, 0	# set a4 = st = 0
j swaptestone
setst:
li a4, 1	# set a4 = st = 1
j swaptestone

swaptestone:
bgt a4, zero, swapperoni	# if st == 1, or st > 0... swapperoni: swap(x0, y0) and swap(x1, y1)
j swaptesttwo
swapperoni:	# swap(x0, y0) and swap(x1, y1)
# swap(x0, y0)
lw a0, 4(sp)	# load y0 from stack 1 slot 2 into a0
lw a1, 0(sp)	# load x0 from stack 1 slot 1 into a1
sw a0, 0(sp)	# save a0 into stack 1 slot 1, it is the new x0
sw a1, 4(sp)	# save a1 into stack 1 slot 2, it is the new y0
# swap(x1, y1)
lw a0, 12(sp)	# load y1 from stack 1 slot 4 into a0
lw a1, 8(sp)	# load x1 from stack 1 slot 3 into a1
sw a0, 8(sp)	# save a0 into stack 1 slot 3, it is the new x1
sw a1, 12(sp)	# save a1 into stack 1 slot 4, it is the new y1
j swaptesttwo

swaptesttwo:
lw a0, 0(sp)	# load x0 into a0
lw a1, 8(sp)	# load x1 into a1
bgt a0, a1, swappityswap	# if x0 > x1... swappityswap: swap(x0, x1) and swap(y0, y1)
j linecont
swappityswap:	# swap(x0, x1) and swap(y0, y1)
# swap(x0, x1)
lw a0, 8(sp)	# load x1 from stack 1 slot 3 into a0
lw a1, 0(sp)	# load x0 from stack 1 slot 1 into a1
sw a0, 0(sp)	# save a0 into stack 1 slot 1, it is the new x0
sw a1, 8(sp)	# save a1 into stack 1 slot 3, it is the new x1
# swap(y0, y1)
lw a0, 12(sp)	# load y1 from stack 1 slot 4 into a0
lw a1, 4(sp)	# load y0 from stack 1 slot 2 into a1
sw a0, 4(sp)	# save a0 into stack 1 slot 2, it is the new y0
sw a1, 12(sp)	# save a1 into stack 1 slot 4, it is the new y1
j linecont

linecont:
lw a0, 0(sp)	# load x0 from stack 1 slot 1
lw a1, 4(sp)	# load y0 from stack 1 slot 2
lw a2, 8(sp)	# load x1 from stack 1 slot 3
lw a3, 12(sp)	# load y1 from stack 1 slot 4
addi sp, sp, -16	# move to stack 2
sub a6, a2, a0 	# a6 = deltax = x1 - x0
sub a0, a3, a1	# a0 = deltay = abs(y1-y0)
jal abs
sw a0, 4(sp) 	# save deltay to stack 2 slot 2
sw zero, 8(sp) # save error = 0 to stack 2 slot 3
addi sp, sp, 16		# move from stack 2 > stack 1

blt a1, a3, ystep	# if y0 < y1... ystep = 1
li a5, -1	# a5 = ystep = -1
j lineplot

ystep:
li a5, 1	# a5 = ystep = 1
j lineplot	# else plot (y,x)

lineplot:
lw a0, 0(sp)	# load x0 from stack 1 slot 1 to a0
lw a1, 4(sp)	# load y0 from stack 1 slot 2 to a1
lw a2, 8(sp)	# load x1 from stack 1 slot 3 to a2
bgt a0, a2, returnhelp	# if x > x1, then go to return help to return to main
jal plot	# Draw the point

lw a0, 0(sp)	# load x from stack 1 slot 1 to a0
lw a1, 4(sp)	# load y from stack 1 slot 2 to a1
addi sp, sp, -16	# move from stack 1 > stack 2
lw a2, 8(sp)	# load error from stack 2 slot 3 to a2
lw a3, 4(sp)	# load deltay from stack 2 slot 2 to a3
add a2, a2, a3	# error = error + deltay
sw a2, 8(sp)	# save a2 to stack 2 slot 3

add a2, a2, a2	# 2*error
addi sp, sp, 16	# move from stack 2 > stack 1
addi a0, a0, 1	# increment x by 1
sw a0, 0(sp)	# save a0 into stack 1 slot 1
bge a2, a6, yincrement	# if 2*error >= deltax... yincrement
j lineplot
yincrement:
add a1, a1, a5	# y = y + ystep
sw a1, 4(sp)	# save y to stack 1 slot 2
addi sp, sp, -16	# move from stack 1 > stack 2
lw a2, 8(sp)	# load error from stack 2 slot 3 to a2
sub a2, a2, a6	# error = error - deltax
sw a2, 8(sp)	# save a2 to stack 2 slot 3
addi sp, sp, 16		# move from stack 2 > stack 1
j lineplot

returnhelp:
#addi sp, sp, 16 # move from stack 1 > no stack
ret
