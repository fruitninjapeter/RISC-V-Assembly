.text
main:

li t2, 0xF0000000
li t3, 0x80000000      # declare number with….

and t4, t2, t3
bne t3, t4, end          # if 2nd bit isn’t set

li a7, 4	# load 4 into register 7; ecall will print string a0
la a0, bitset
ecall

end:
li a7, 10
ecall

.data
bitset: .string "bit is set"
