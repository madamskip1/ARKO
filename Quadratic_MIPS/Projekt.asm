	.data
askFileName:	.asciiz 	"File name: \n"
loadError: 	.asciiz 	"Load file error. Interrupted."
outputName:	.asciiz 	"output.bmp"
fileName:	.space 		64 
header:		.space 		54	# file header
size:		.space 4		# photo width dim
photoSize:	.space 4
a:		.space 4
b:		.space 4 
c:		.space 4 

photoStart:	.space 4
offset:		.space 4
nothing:		.space 4
getA:		.asciiz 	"Enter A: \n"
getB:		.asciiz		"Enter B: \n"
getC:		.asciiz		"Enter C: \n"
newLine:	.asciiz		"\n" 


# s7 - file descriptor
# s6 - array
# s5 - output file descriptor

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
	#  0000 0000 . 0000 0000 0000 0000 0000 0000
	
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
	#li $t0, 1024
	#sll $t0, $t0, 16
	#sw $t0, size
	
	
 	#j auxiliaryLines
 	#j mainLines
 	#j drawFunction
 	
##########################################################
	# print askFileName
	la $a0, askFileName
	li $v0, 4
	syscall
	
	# read fileName from user input
	la $a0, fileName
	li $a1, 64
	li $v0, 8
	syscall

	la $t0, fileName
	
removeNewLine:
	lb $t1, ($t0)
	beqz $t1, openFile
	addi $t0, $t0, 1
	bne $t1, '\n', removeNewLine
	subi $t0, $t0, 1
	sb $zero, ($t0)
	

openFile:
	la $a0, fileName
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall
	
	# check if there was an  error
	bltz $v0, openError
	

fileInfo:
	move $s7, $v0		# $s7 -> file descriptor
	
	move $a0, $s7
	la $a1, nothing
	li $a2, 2
	li $v0, 14
	syscall
	
	move $a0, $s7
	la $a1, photoSize
	li $a2, 4
	li $v0, 14
	syscall
	
	move $a0, $s7
	la $a1, nothing
	li $a2, 4
	li $v0, 14
	syscall
	
	move $a0, $s7
	la $a1, offset
	li $a2, 4
	li $v0, 14
	syscall
	
	move $a0, $s7
	la $a1, nothing
	li $a2, 4
	li $v0, 14
	syscall
	
	move $a0, $s7
	la $a1, size
	li $a2, 4
	li $v0, 14
	syscall
	
	
imageData:
	# locate memory
	lw $s1, photoSize
	move $a0, $s1
	li $v0, 9
	syscall
	
	move $s6, $v0
	sw $s6, photoStart
	
	move $a0, $s7
	li $v0, 16
	syscall
	
	la $a0, fileName
	la $a1, 0
	la $a2, 0
	li $v0, 13
	syscall
	# load image data	
	move $s7, $v0
	bltz $s7, openError
	
	lw $s3, photoStart
	lw $s4, photoSize
	lw $s5, offset
	
	move $a0, $s7
	la $a1, ($s3)
	la $a2, ($s4)
	li $v0, 14
	
	syscall
	
closeFile:
	move $a0, $s7
	li $v0, 16
	syscall
	
	#b end
	j auxiliaryLines
	

#####################################################
	
auxiliaryLines:
	addu $s3, $s3, $s5
	li $t0, 0X80	# $t0 - color
	lw $t7, size
	addiu $t8, $t7, -2	# $t8 - not draw
	div $t7, $t7, 8
	addiu $t1, $t7, -2	# $t1 - min 
	addiu $t2, $t7, 2	# $t2 - max
	li $t3, 0		# $t3 - col
	li $t4, 1		# $t4 - row
	
	li $t5, 1		# vertical (pionowy) counter
	li $t6, 1		# horizontal (poziomy) counter
	la $t7, ($s3)		# pixel adress
	addi $t7, $t7, -3
	lw $s0, size
	
drawAuxiliaryLines:
	li $t0, 0X80
	addi $t7, $t7, 3
	addiu $t3, $t3, 1
	addiu $t5, $t5, 1
	bgt $t3, $s0, nextRowAuxiliary
	bgt $t4, $s0, mainLines
	
	verticalAuxiliary:
		blt $t5, $t1, horizontalAuxiliary
		bgt $t5, $t2, resetVertical
		bge $t3, $t8, horizontalAuxiliary
		sb $t0, ($t7)
		addi $t7, $t7, 1
		sb $t0, ($t7)
		addi $t7, $t7, 1
		li $t0, 0X00
		sb $t0, ($t7)
		addi $t7, $t7, -2
		j horizontalAuxiliary
	resetVertical:
		li $t5, 3
	horizontalAuxiliary:
		blt $t6, $t1, drawAuxiliaryLines
		bgt $t6, $t2, resetHorizontal
		bge $t4, $t8, drawAuxiliaryLines
		sb $t0, ($t7)
		addi $t7, $t7, 1
		sb $t0, ($t7)
		addi $t7, $t7, 1
		li $t0, 0X00
		sb $t0, ($t7)
		addi $t7, $t7, -2
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

	li $t0, 0xFF
	lw $t1, size

	div $t2, $t1, 2
	addiu $t3, $t2, -6
	addiu $t4, $t2, 6
	move  $t2, $t1
	
	li $t1, 0
	li $t5, 0 # row
	li $t6, 0 # col
	la $t7, ($s3)
	addi $t7, $t7, -3
	
	
drawMainLines:
	li $t0, 0xFF
	addiu $t6, $t6, 1
	addiu $t7,$t7, 3

	bge $t5, $t2, drawFunction
	bge $t6, $t2, nextRowMainLines
	
	vertical:
		blt $t6, $t3, horizontal
		bgt $t6, $t4, horizontal
		sb $t0, ($t7)
		addi $t7, $t7, 1
		li $t0, 0X00
		sb $t0, ($t7)
		addi $t7, $t7, 1
		sb $t0, ($t7)
		addi $t7, $t7, -2
	horizontal:
		blt $t1, $t3, drawMainLines
		bgt $t1, $t4, drawMainLines
		sb $t0, ($t7)
		addi $t7, $t7, 1
		li $t0, 0X00
		sb $t0, ($t7)
		addi $t7, $t7, 1
		sb $t0, ($t7)
		addi $t7, $t7, -2
	
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
	bge $s7, $s2, saveFile 
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
	
	li $t1, 0x00 # color
	
	lw $t2, photoStart	# adres
	#lw $t3, offset
	add $t2, $t2, $t3
	
#mul $t0, $t0, -1
	move $t3, $s2
	div $t3, $t3, 2
	add $t0, $t0, $t3
	mul $t0, $t0, $s2
	add $t0, $t0, $s7
	addi $t0, $t0, 15
	mul $t0, $t0, 3
	
	add $t2, $t2, $t0
	
	sb $t1, ($t2)
	addi $t2, $t2, 1
	sb $t1, ($t2)
	addi $t2, $t2, 1
	sb $t1, ($t2)
	addi $t2, $t2, 1
	#sw $t1, ($t2)
	
	
	j drawFunctionLoop
	
#####################################################

saveFile:
	# create output file
	la $a0, outputName
	li $a1, 1
	li $a2, 0
	li $v0, 13
	syscall
	
	move $s5, $v0
	bltz $s5, openError
	
	## write header to file
	#li $v0, 15
	#move $a0, $s5
	#la $a1, header
	#addi $a2, $zero, 54
	#syscall
	
	lw $t0, photoSize
	lw $t1, photoStart

	move $a0, $s5
	la $a1, ($t1)
	la $a2, ($t0)
	li $v0, 15
	syscall
	
	move $a0, $5
	li $v0, 16
	
	j end
	
#####################################################	

openError:
	la $a0, loadError
	li $v0, 4
	syscall

#####################################################

end:	
	# close 
	li $v0, 10
	syscall
