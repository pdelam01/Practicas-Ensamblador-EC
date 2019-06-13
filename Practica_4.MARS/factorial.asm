	.data
cad1: .asciiz "Introduzca un número: "
cad2: .asciiz "El factorial es: "
	.globl main
	.text
	
main: 
	li $v0, 4               #imprimimos la cadena1
	la $a0, cad1
	syscall
	
	li $v0, 5		#leemos el número
	syscall		
	move $a0, $v0		#lo guardamos en a0
	
	jal factorial
	move $t0, $v0		#guardamos el resultado en $t0
	
	li $v0, 4		#imprimimos cad2
	la $a0, cad2
	syscall
	
	li $v0, 1
	move $a0, $t0		#imprimimos el numero del resultado
	syscall 
	
	li $v0, 10
	syscall
	
factorial:
	li $t1, 1
	li $t2, 1
	bucle:
		mul $t2, $t2, $t1
		beq $a0, $t1, fin
		addi $t1, $t1, 1
		j bucle
fin:	
	move $v0,$t2
	jr $ra
	

		
	
	
	
	
