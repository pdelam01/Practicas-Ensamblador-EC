.data

cad:		.asciiz "La media de la suma de los 2 vectores es: "

# El primer vector suma 325 y el segundo 200, en total 525. 
# En total son 14 valores, así que 525/14 = 37 es el valor que debe mostrar.

vector1: 	.word 4, 1, 20, 30, 12, 17, 27, 29, 87, 98
vector2:	.word 100, 50, 10, 40

.text
.globl main

main:


	la $a0, vector1 	# Enviamos en $a0 el puntero al vector1
	li $a1, 10		# Enviamos en $a1 el valor del total de valores que posee el vector1
	la $a2, vector2 	# Enviamos en $a2 el puntero al vector2
	li $a3, 4		# Enviamos en $a3 el valor del total de valores que posee el vector2
	
	jal subrutina1
	
	move $t0, $v0

	li $v0, 4		# Código del sistema para imprimir cadena (print_string)
	la $a0, cad		# En $a0 enviamos la cadena
	syscall			# Llamamos al sistema
	
	li $v0, 1		# Código del sistema para imprimir entero (print_int)
	move $a0, $t0		# Movemos a $a0 el valor que queremos imprimir
	syscall			# Llamamos al sistema
	
fin:	li $v0, 10
	syscall
	
	
subrutina1:
	addi $sp, $sp, -4	# Preparamos la pila para guardar el $ra actual
	sw $ra, ($sp)		# Guardamos en la pila el $ra
	
	move $t5, $a1		# Guardamos en $t5 el número de enteros que contiene el vector 1
	move $t6, $a3		# Guardamos en $t6 el número de enteros que contiene el vector 2

	jal SumaVector
	
	addi $sp, $sp, -4	# Preparo la pila
	sw $v0, ($sp)		# Guardo en la pila la suma del primer vector
	
	
	move $a0, $a2		# Movemos a $a0 la direcc. de memoria del vector 2
	move $a1, $a3		# Movemos a $a1 el número de valores que contiene vector 2
	
	# Llamamos de nuevo a SumaVector y devolverá la suma total de los valores del vector 2
	
	jal SumaVector
	
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
		
SumaVector:

	li $t0, 0 # Contador para el bucle que recorre el vector
	li $t1, 0 # Contador total de la suma de los valores del vector

bucle:
	# Si $t0 es =  a $a1, hemos acabado de leer los valores del vector
	beq $t0, $a1, finSumaVector

	# Actualizamos el contador de valores leídos
	addi $t0, $t0, 1

	# Cargamos uno de los valores del vector
	lw $t2, ($a0)
	# Actualizamos para leer el siguiente número
	addi $a0, $a0, 4

	# Sumamos en $t1 el valor leído del vector
	add $t1, $t1, $t2

	j bucle
	
finSumaVector:

	# Devolvemos el valor de nuevo a la función principal
	move $v0, $t1
	jr $ra
	
