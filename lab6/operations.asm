.text
.globl abs
.globl abscalc
.globl plot
.globl plotpoint

abs: # absolute value of a0
blt a0, zero, abscalc	# if less than zero, begin calculating absolute value
ret
abscalc: # absolute value calculation
li a2, 0xFFFFFFFF
xor a0, a0, a2
addi a0, a0, 1
ret 

plot:
bgt a4, zero, plotyx # if a4 = st = 1, plot(y,x), else plot(x,y)
# plot value of (x,y) -> (a0, a1) to make the respective pixel white (+x = +4, +y = +1024)
li a2, 4
mul a0, a0, a2
li a2, 1024
mul a1, a1, a2
j plotpoint
plotyx:
# plot value of (y,x) -> (a0, a1) to make the respective pixel white (+x = +4, +y = +1024)
li a2, 1024
mul a0, a0, a2
li a2, 4
mul a1, a1, a2
j plotpoint
plotpoint:
li a2, 0x10010000
add a2, a2, a0
add a2, a2, a1
sw s0, 0(a2)
ret