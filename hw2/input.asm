.text
.global main

main:

li a0, 5

jal factorial
mv t0, a0

li a7, 4
la a0, factorialanswer
ecall

li a7, 1
mv a0, t0
ecall

li a7, 10
ecall


.data
factorialanswer: .string "The factorial result is: "