	.data
size:		.space 4	# photo size
a:		.space 4
b:		.space 4 
c:		.space 4 

getA:		.asciiz 	"Enter A: \n"
getB:		.asciiz		"Enter B: \n"
getC:		.asciiz		"Enter C: \n"
newLine:	.asciiz		"\n" 


	.text
	.globl main
	
main:
	# print getA
	la $a0, getA
	li $v0, 4
	syscall
	
	# get A
	li $v0, 5
	syscall
	sll $v0, $v0, 24
	sw $v0, a
	#  0000 0000 0000 0000 . 0000 0000 0000 0000
	
	# print getB
	la $a0, getB
	li $v0, 4
	syscall
	
	# get B
	li $v0, 5
	syscall	
	sll $v0, $v0, 24
	sw $v0, b
	
	# print getC
	la $a0, getC
	li $v0, 4
	syscall
	
	# get C
	li $v0, 5
	syscall
	sll $v0, $v0, 24
	sw $v0, c

	
	###
	li $t0, 512
	#sll $t0, $t0, 16
	sw $t0, size
	
	
 	j auxiliaryLines
 	j mainLines
 	j drawFunction
 	
##########################################################
	
auxiliaryLines:
	li $t0, 0x00808000	# $t0 - color
	lw $t7, size
	addiu $t8, $t7, -2	# $t8 - not draw
	div $t7, $t7, 8
	addiu $t1, $t7, -2	# $t1 - min 
	addiu $t2, $t7, 2	# $t2 - max
	li $t3, 0		# $t3 - col
	li $t4, 1		# $t4 - row
	
	li $t5, 1		# vertical (pionowy) counter
	li $t6, 1		# horizontal (poziomy) counter
	la $t7, ($gp)		# pixel adress
	addi $t7, $t7, -4
	lw $s0, size
drawAuxiliaryLines:
	addi $t7, $t7, 4
	addiu $t3, $t3, 1
	addiu $t5, $t5, 1
	bgt $t3, $s0, nextRowAuxiliary
	bgt $t4, $s0, mainLines
	
	verticalAuxiliary:
		blt $t5, $t1, horizontalAuxiliary
		bgt $t5, $t2, resetVertical
		bge $t3, $t8, horizontalAuxiliary
		sw $t0, ($t7)
		j horizontalAuxiliary
	resetVertical:
		li $t5, 3
	horizontalAuxiliary:
		blt $t6, $t1, drawAuxiliaryLines
		bgt $t6, $t2, resetHorizontal
		bge $t4, $t8, drawAuxiliaryLines
		sw $t0, ($t7)
		j drawAuxiliaryLines
	resetHorizontal:
		li $t6, 3
		j drawAuxiliaryLines
	

nextRowAuxiliary:
	addi $t4, $t4, 1
	addi $t6, $t6, 1
	li $t3, 1
	li $t5, 1
	j drawAuxiliaryLines

#####################################################


mainLines:
	li $t0, 0x00ff0000
	lw $t1, size

	div $t2, $t1, 2
	addiu $t3, $t2, -6
	addiu $t4, $t2, 6
	move  $t2, $t1
	
	li $t1, 0
	li $t5, 0 # row
	li $t6, 0 # col
	la $t7, ($gp)
	addi $t7, $t7, -4
	
	
drawMainLines:
	addiu $t6, $t6, 1
	addiu $t7,$t7, 4

	bge $t5, $t2, drawFunction
	bge $t6, $t2, nextRowMainLines
	
	vertical:
		blt $t6, $t3, horizontal
		bgt $t6, $t4, horizontal
		sw $t0, ($t7)
	horizontal:
		blt $t1, $t3, drawMainLines
		bgt $t1, $t4, drawMainLines
		sw $t0, ($t7)
	
	j drawMainLines

nextRowMainLines:
	li $t6, 0
	addiu $t5, $t5, 1
	addiu $t1, $t1, 1
	j drawMainLines

	
#####################################################
	

drawFunction:
	li $s0, 0xFF000000 # $s0 -> x axis (-1)
	lw $s2, size
	lw $s3, a
	lw $s4, b
	lw $s5, c
	li $s7, 1 # $s7 -> counter

	li $t0, 0x01000000
	div $s6, $t0, $s2
	mul $s6, $s6, 2
	li $t0, 2
	divu $s2, $t0
	mflo $s1
	
drawFunctionLoop:
	bge $s7, $s2, end 
	move $t7, $s7
	addi $s7, $s7, 1
	
	# calc a*x
	mult $s3, $s0
	mfhi $t2
	mflo $t3
	sll $t2, $t2, 8
	srl $t3, $t3, 24
	or $t0, $t2, $t3
	

	#calc a*x^2
	mult $t0, $s0
	mfhi $t2
	mflo $t3
	sll $t2, $t2, 8
	srl $t3, $t3, 24
	or $t0, $t2, $t3

		
	# calc a*x^2 + bx
	mult $s4, $s0
	mfhi $t2
	mflo $t3
	sll $t2, $t2, 8
	srl $t3, $t3, 24
	or $t1, $t2, $t3
	add $t0, $t0, $t1


	#calc a*x^2 + bx + c
	add $t0, $t0, $s5
	
	
	
	sra $t0, $t0, 20
	

	
	add $s0, $s0, $s6  #add 1 to x (1 -> 1/size)

	
	li $t1, 2
	div $t1, $s2, $t1
	bgt $t0, $t1, drawFunctionLoop
	mul $t1, $t1, -1
	blt $t0, $t1, drawFunctionLoop
	

	##### DTUTAJ DOBRZE
	
	li $t1, 0x00FFFFFF # color
	
	la $t2, ($gp)	# adres
		
	mul $t0, $t0, -1
	move $t3, $s2
	div $t3, $t3, 2
	add $t0, $t0, $t3
	mul $t0, $t0, $s2
	add $t0, $t0, $s7
	mul $t0, $t0, 4
	
	add $t2, $t2, $t0
	
	
	sw $t1, ($t2)
	
	j drawFunctionLoop
	

#####################################################

end:	
	# close 
	li $v0, 10
	syscall
