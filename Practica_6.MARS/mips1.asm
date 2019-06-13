.data

cad:	.asciiz "La suma de los elementos del vector es: "
vector: .word 4, 1, 20, 30, 12, 17, 27, 29, 87, 98

.text
.globl main

main:


	la $a0, vector		# Enviamos en $a0 el puntero al vector
	li $a1, 10		# Enviamos en $a1 el valor del total de valores que posee el vector
	
	jal SumaVector
	
	move $t0, $v0

	li $v0, 4		# Código del sistema para imprimir cadena (print_string)
	la $a0, cad		# En $a0 enviamos la cadena
	syscall			# Llamamos al sistema
	
	li $v0, 1		# Código del sistema para imprimir entero (print_int)
	move $a0, $t0		# Movemos a $a0 el valor que queremos imprimir
	syscall			# Llamamos al sistema
	
fin:	li $v0, 10
	syscall
	
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