	.data
cad1: .asciiz "La suma resulta: "
	
datos1:
	.byte 14,23
	.align 2
	.word 47
	.align 1
	.half 9,12,15
	.align 2
datos2:
	.space 4
	.byte 'c', 'p'
	
	.globl main
	.text

main:
	la $t0, datos1
	lw $t1, 4($t0)
	lh $t2, 12($t0)
	add $t3, $t1, $t2
	sw $t3, 16($t0)
	
	li $v0,4
	la $a0, cad1
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 10
	syscall