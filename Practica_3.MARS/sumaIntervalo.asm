	.data

cad: .asciiz "Introduzca un numero: "
cad1: .asciiz "La suma del intervalo es: "

	.globl main
	.text
	
main: 
	li $v0, 4 
	la $a0, cad
	syscall
	
	li $v0, 5
	syscall
	move $t0,$v0
	
	li $t1, 0
	li $t2, 0
	addi $t3, $t0, 1
  
  bucle: 
  	beq $t1,$t3, fin
  	add $t2, $t2, $t1
  	addi $t1, $t1, 1
	j bucle
  fin:
  	li $v0, 4
  	la $a0, cad1
  	syscall
  	
  	li $v0, 1
  	move $a0, $t2
  	syscall
  	
  	li $v0, 10		
   	syscall
  	 
  	   
	
	
