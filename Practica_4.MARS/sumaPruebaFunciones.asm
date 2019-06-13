	.data
	
cad1: .asciiz "Escriba un numero: "
cad2: .asciiz "El resultado es: "

	.globl main
	.text
	
main:
	li $v0, 4
	la $a0, cad1
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, cad1
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	jal suma
	
	li $v0, 4
	la $a0, cad2
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 10
	syscall
	
suma:
	add $t3, $t0, $t1
	jr $ra
	
	