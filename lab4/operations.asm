.text
.globl addnums
.globl subnums
.globl multnums
.globl multend
.globl divnums
.globl andnums
.globl ornums
.globl xornums

addnums:	# int addnums (int a1, int a2);
add a0, a1, a2
ret

subnums:	# int subnums (int a1, int a2);
sub a0, a1, a2
ret

multnums:	# int multnums (int a1, int a2);
addi a0, zero, 0	# int a0 = 0
addi a3, zero, 0	# int a3 = 0; a3 will be the counter
multcont:
beq a2, a3, multend	# If we added a2 = # of times, given by counter a3 then jump to multend function to return
add a0, a0, a1		# add a1 to a0
addi a3, a3, 1		# add 1 to counter a3
j multcont
multend:
ret

divnums:	# int divnums (int a1, int a2);
div a0, a1, a2
ret

andnums:	# int andnums (int a1, int a2);
and a0, a1, a2
ret

ornums:		# int ornums (int a1, int a2);
or a0, a1, a2
ret

xornums:	# int xornums (int a1, int a2);
xor a0, a1, a2
ret
