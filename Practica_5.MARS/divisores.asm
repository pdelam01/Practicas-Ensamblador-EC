	.data
	
cad:	.asciiz "\nIntroduzca un número positivo: "
cad2:	.asciiz "\nEl número ha de ser positivo!"
cad3:	.asciiz "\nEl número insertado tiene un número par de divisores "
cad4: 	.asciiz "\nEl número insertado tiene un número impar de divisores "

	.globl main
	.text
main:	

	li $v0, 4		
	la $a0, cad	
	syscall			

	li $v0, 5		
	syscall			
	move $a0, $v0	
	
	la $a1, cad2		# Segundo argumento: cadena de error
	
	jal funppal		# Llamada a la función para ver si es primo
	
	beq $v0, $zero, espar	# Si el resultado es 0, no es primo
	li $t0, -1	
	beq $v0, $t0, negativo	# Si el resultado es -1, ha habido un error
	la $a0, cad3		# Si el resultado no es 0 ni -1, es primo
	j sigue

espar:
	la $a0, cad4
	
sigue:	
	li $v0, 4	#Imprimimos la cadena correspondiente
	syscall
	
negativo:
	li $v0, 10
	syscall  #Fin de la función main


	# Función principal
funppal:
	bgt $a0, $zero, positivo	# Comprobamos que sea positivo
	
	li $v0, 4	# Si no lo es, imprimimos la cadena de error de $a1
	move $a0, $a1
	syscall		# El número no es positivo!!
	
	li $v0, -1	# Devolvemos -1 que es el código de error
	jr $ra

positivo:	#Si el número es positivo...

	addi $sp,$sp, -4	#Como vamos a llamar a otra función, almacenamos
	sw $ra, ($sp)		# el registro $ra en la pila

	jal calcula_divisores	#Esta función devuelve en $v0 el nº e divisores del número almcenado en $a0 (argumento de la función)

	lw $ra, ($sp)	#Desapilamos $ra
	addi $sp, $sp, 4
	li $t0, 2
	div $v0, $t0	# Dividimos entre 2
	mfhi $v0	# Y guardamos el resto... será 0 si es par, 1 si es impar
	
	jr $ra
	

calcula_divisores:
	li $t1, 0	#inicializamos el contador de divisores
	li $t2, 1	#El primer número que vamos a analizar si es divisor es el 1

bucle:
	bgt $t2, $a0, fin	#Si el número a analizar es mayor, hemos acabado	
	div $a0, $t2	#Dividimos el número entre el posible divisor
	mfhi $t3	#Nos quedamos con el resto
	addi $t2, $t2, 1	#Pasamos al siguiente número
	bne $t3, $zero, bucle	#Si el resto no es 0, no es divisor. Seguimos mirando...
	addi $t1, $t1, 1	#Si el resto es 0, es divisor. Sumamos uno al contador de divisores
	j bucle		#Seguimos mirando

fin:	
	move $v0, $t1	#Pasamos el número de divisres a $v0
	jr $ra