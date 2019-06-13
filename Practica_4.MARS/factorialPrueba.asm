	.data
	
cad1: .asciiz "Introduzca un numero: "
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
	
	move $a0, $t0
	jal factorial
	move $t4, $v0
	
	li $v0, 4
	la $a0, cad2
	syscall
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 10
	syscall
	
	
factorial:
	li $t1, 1	#contador
	li $t2, 1	#variable multiplicacion
	
	bucle:
		mul $t2, $t2, $t1
		beq $a0, $t1, fin
		addi $t1,$t1, 1
		j bucle
	
fin:
	move $v0, $t2
	jr $ra