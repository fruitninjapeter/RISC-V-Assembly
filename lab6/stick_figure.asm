.text	# Lab 6: Stick Figure
.global main

main:
li s0, 0xFFFFFF	# define s0 as the color white
li a0, 30
li a1, 100
li a2, 20
jal circle # Circle(30,100,20)  head
li a0, 30
li a1, 80
li a2, 30
li a3, 30
jal line # Line(30,80,30,30)  body
li a0, 20
li a1, 1
li a2, 30
li a3, 30
jal line # Line(20,1,30,30)   left leg
li a0, 40
li a1, 1
li a2, 30
li a3, 30
jal line # Line(40,1,30,30)   right leg
li a0, 15
li a1, 60
li a2, 30
li a3, 50
jal line # Line(15,60,30,50)  left arm
li a0, 30
li a1, 50
li a2, 45
li a3, 60
jal line # Line(30,50,45,60)  right arm
li a0, 24
li a1, 105
li a2, 3
jal circle # Circle(24,105,3)   left eye
li a0, 36
li a1, 105
li a2, 3
jal circle # Circle(36,105,3)   right eye
li a0, 25
li a1, 90
li a2, 35
li a3, 90
jal line # Line(25,90,35,90)  mouth center
li a0, 25
li a1, 90
li a2, 20
li a3, 95
jal line # Line(25,90,20,95)  mouth left
li a0, 35
li a1, 90
li a2, 40
li a3, 95
jal line # Line(35,90,40,95)  mouth right
