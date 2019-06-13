	.data
datos1: 
.half 4,7,2
.align 2
.word 1, -5
.byte 4
.align 1
.half 3
.align 2
.word -3
.space 2
.byte 'c'

datos2: .byte 2,3,5,7

salto: .asciiz "\n\n"

	.globl main
	.text

main: 
	la $t0,datos1
	lw $t1, 8($t0)
	lh $t2, 18 ($t0)
	add $t3, $t1, $t2
	sh $t3, 24($t0)
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 4
	la $a0, salto		#IMPRIMIMOS SALTO DE LINEA
	syscall
	
	la $t4, datos2
	lb $t5, -1($t4)
	addi $t6, $t5, 2
	sb $t6, -11($t4)
	
	li $v0, 1
	move $a0, $t6
	syscall
	
	
	
