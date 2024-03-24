.text
main:

li t2, 0x30000000
li t3, 0x1
slli t2, t2, 1
srli t2, t2, 31
bne t2, t3, end
li a7, 4
la a0, bitset
ecall

end:
#li a7, 4
#la a0, bitaintset
#ecall

li a7, 10
ecall

.data
bitset: .string "bit is set"
#bitaintset: .string "bit is not set"