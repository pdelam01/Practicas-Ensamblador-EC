# 1. Se pide realizar un programa que calcule la suma de los elementos 
# de un vector inicialmente declarado en el segmento de datos mediante
#  una subrutina. Dicha subrutina recibirá un puntero a dicho vector y 
# su tamaño y devolverá la suma de todos los elementos del vector. 
# NOTA: Recordar que las subrutinas reciben los argumentos en los 
# registros $a0...$a3 y devuelven los resultados en $v0 o $v1

	.data
cad1:	.asciiz "La suma de los elementos del vector es: "
vector: .word 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	.globl main
	.text
	
main: 
	la $a0, vector		#Apuntamos al vector
	li $a1, 10		#Tamanyo del vector
	
	jal sumaVector
	move $t0, $v0
	
	li $v0, 4
	la $a0, cad1
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall
	
sumaVector:
	li $t0, 0		#Contador del bucle
	li $t1, 0		#Suma
	
	bucle:
		beq $t0, $a1, fin
		addi $t0, $t0, 1
		lw $t2, ($a0)
		addi $a0, $a0 ,4
		add $t1, $t1, $t2
		
		j bucle
		
	fin:	
		move $v0, $t1
		jr $ra
