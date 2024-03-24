.text
.global main
.global readstring

initial:
li s0, 10	# s0 = 10 = ascii of <enter>, or new line
li s1, 0	# s1 = 0 = NULL

main:
la a0, enter
jal printstring		# "Enter word: "
la t0, store
la t1, store
jal readstringaddy
beq t0, t1, quitprogram 	# if <enter> is the first char, proceed to quit the program
la a0, original			# load address of original label to a0
jal printstring			# "Original word: "
jal ogwordaddy
la a0, alphabet
jal printstring		# "Alphabetized word: "
la t0, store
jal awordaddy

awordaddy:
sw ra, alphabetaddy, s2
awordloop:
lb a3, (t0)
lb a4, 1(t0)
beq a4, s1, awordcheck
bgt a3, a4, charswitch
addi t0, t0, 1
j awordloop
charswitch:
sb a4, (t0)
sb a3, 1(t0)
addi t0, t0, 1
addi a2, a2, 1
j awordloop
awordcheck:
la t0, store
beq a2, zero, printaword
li a2, 0
j awordloop
printaword:
lb a0, (t0)		# load byte/char from memory to a0
beq a0, s1, mainend	# if byte loaded in is null \0, go next
jal printchar		# print char a0
sb s1, (t0)
addi t0, t0, 1		# increment to next byte location
j printaword		# loop again

mainend:
la a0, line
jal printstring
j main

readstringaddy:
sw ra, enteraddy, s2
readstring:
jal readchar
beq a0, s0, entertomain		# if enter is pressed... also not storing the <enter> key
sb a0, (t0)		# save user input char into byte location
addi t0, t0, 1		# go to next byte location
j readstring		# loop again
entertomain:
lw ra, enteraddy
ret 

ogwordaddy:
sw ra, ogaddy, s2
ogword:
lb a0, (t1)		# load byte/char from memory to a0
beq a0, s1, ogtomain	# if byte loaded in is null \0, go next
jal printchar		# print char a0
addi t1, t1, 1		# increment to next byte location
j ogword		# loop again
ogtomain:
lw ra, ogaddy
ret

quitprogram:
la a0, exiting
jal printstring
jal exit

.data 
# allocate room to store up to 20 characters
store: .space 21
.space 3
enteraddy: .space 4
ogaddy: .space 8
alphabetaddy: .space 8
# strings below
enter: .string "Enter word: "
original: .string "\nOriginal word: "
alphabet: .string "\n\nAlphabetized word: "
line: .string "\n"
exiting: .string "Exiting"
