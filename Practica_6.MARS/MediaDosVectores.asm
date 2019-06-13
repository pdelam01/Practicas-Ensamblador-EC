# 2. Realizar un programa que calcule la media de dos vectores. Dicho programa debe 
# contener dos subrutinas:
#
# • La primera subrutina recibirá los dos punteros a los vectores en dos registros y 
# los tamaños de cada una de ellas en otros dos registros. Esta subrutina llamará a 
# la segunda subrutina dos veces (una por cada vector) que devolverá la suma de los 
# elementos del vector que reciba. Finalmente la primera subrutina devuelve la media 
# total (en número entero) de todos los valores. Por ejemplo: Si el primer vector es 
# { 3,3,3,4 } y el segundo vector es { 4,4 } la suma total del primero es 13, la suma 
# total del segundo es 8, 13 + 8 = 21 y 21 entre 6 (número total de elementos del 
# vector 1 y 2) es 3.
#
#
# • La segunda subrutina recibirá como argumento una dirección de memoria a un vector 
# y su tamaño. Se encargará de sumar todos los elementos del vector y devolverlo.

	.data
cad: 		.asciiz "La media de los dos vectores es: "
vector1: 	.word 4, 1, 20, 30, 12, 17, 27, 29, 87, 98
vector2:	.word 100, 50, 10, 40
	.globl main
	.text
	
main:
	la $a0, vector1
	li $a1, 10
	la $a2, vector2
	li $a3, 4
	
	jal subrutina1
	
	li $v0, 4		
	la $a0, cad		
	syscall			
	
	li $v0, 1		
	move $a0, $t0		
	syscall			
	
	li $v0, 10
	syscall
	

subrutina1:
	addi $sp, $sp, -4	
	sw $ra, ($sp)		# Guardamos en la pila el $ra
	
	
	jal sumaVector
	
	addi $sp, $sp, -4	# Preparo la pila
	sw $v0, ($sp)		# Guardo en la pila la suma del primer vector
	
	move $a0, $a2		# Movemos a $a0 la direcc. de memoria del vector 2
	move $a1, $a3		# Movemos a $a1 el número de valores que contiene vector 2
	jal sumaVector
	
	move $t3, $v0		# Guardamos en $t3 la suma de los valores del vector 2
	
	lw $t2, ($sp)		# Desapilo en $t2 la suma de los valores del vector 1 que tenía en la pila
	addi $sp, $sp, 4	# Actualizo la pila
	
	add $t2, $t2, $t3	# Sumamos los valores de las sumas de ambos vectores
	add $t5, $t5, $t6	# Sumamos el número total de enteros que tienen ambos vectores
	
	div $t2, $t5		# Dividimos la suma de valores entre la suma de números que poseen ambos vectores para hallar la media
	mflo $v0
	
	
	lw $ra ($sp)		# Desapilamos el $ra para poder volver a la función main
	addi $sp, $sp, 4	# Actualizamos la pila
	
	jr $ra		
					
	
sumaVector:
	li $t0, 0		#contador
	li $t1, 0		#suma
	
	bucle:
		beq $t0, $a1, fin
		addi $t0, $t0, 1
		lw $t2, ($a0)
		addi $a0, $a0, 4
		add $t1, $t1, $t2
		j bucle
	fin:
		move $v0, $t1
		jr $ra