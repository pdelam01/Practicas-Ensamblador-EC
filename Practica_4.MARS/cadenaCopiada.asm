	.data
cad1: .asciiz "Introduzca una cadena: "
cad2: .asciiz "\nLa cadena introducida resulta: "
cadLeida: .space 100
cadCopiada: .space 100

	.globl main
	.text

main:
	li $v0, 4
	la $a0, cad1
	syscall
	
	li $v0, 8
	la $a0, cadLeida
	li $a1, 100
	syscall
	
	la $a0, cadLeida
	la $a1, cadCopiada
	
	jal strcpy
	
	li $v0, 4
	la $a0, cad2
	syscall
	
	li $v0, 4
	la $a0, cadCopiada
	syscall
	
	li $v0, 10
	syscall
	
	
	strcpy:
		bucle:
			lb $t0, ($a0)
			sb $t0,($a1)
			beq $t0, $zero, fin
			addi $a0, $a0, 1
			addi $a1, $a1, 1
			j bucle
		fin:
			jr $ra
			
	
	
	
	