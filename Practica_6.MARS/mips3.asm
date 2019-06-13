# 2.Realizar un programa que solicite al usuario una cadena de texto y tres números 
# enteros. A continuación se llamará a una subrutina cuya tarea es la de contabilizar 
# el número de caracteres de la cadena y el número de caracteres ASCII que posee 
# dicha cadena en función de los 3 números solicitados al usuario. Es decir, si el 
# usuario inserta:

# Cadena: “La cadena de texto es esta”
# Número 1: 97
# Número 2: 99
# Número 3: 101

# El 97 es la letra ‘a’, el 99 la letra ‘c’ y el 101 la letra ‘e’
# Con lo cual el programa debe devolver:

# La cadena texto introducida por el usuario posee 28 caracteres 
# 4 a, 1 c, 5 e.

# Pistas: Se pueden reservar 3 espacios de un byte en el segmento de datos para guardar 
# los caracteres como “bytes” y posteriormente leerlos.
# Se pueden pasar en $a0, $a1, $a2 y $a3 todos los argumentos, no es necesario usar 
# la pila.
# Se debe utilizar la pila para devolver al menos dos de los cuatro resultados que 
# proporciona la subrutina.

.data
cadIntro1: .asciiz "A continuación vamos a soliciarle una cadena de texto y tres números enteros\nIntroduzca una cadena de texto: "
cadIntro2: .asciiz "\nIntroduzca  un número entero: "
cadResul1: .asciiz "\nLa cadena introducida por el usuario posee "
cadResul2: .asciiz " caracteres\n"
cadResul3: .asciiz ", "
cadResul4: .ascii "\0"
cadLeida: .space 1000
letra1: .space 1
	.ascii "\0"
letra2:	.space 1
	.ascii "\0"
letra3:	.space 1
	.ascii "\0"

	.text
	.globl main
main:

	# Solicitamos la cadena de texto
	
	li $v0, 4 		# Código del sistema para imprimir una cadena (print_string)
	la $a0, cadIntro1	# Cargamos en $a0 la cadena a imprimir
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	li $v0, 8	 	# Llamada al sistema que lee una cadena de máximo 1000
	la $a0, cadLeida 	# caracteres y la almacena en la dirección especificada 
	li $a1, 101	 	# por la etiqueta cadLeida
	syscall		 	# Realizamos la llamada al sistema para que se ejecute
	
	# Solicitamos el primer entero ASCII
	
	li $v0, 4 		# Código del sistema para imprimir una cadena (print_string)
	la $a0, cadIntro2	# Cargamos en $a0 la cadena a imprimir
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	li $v0, 5	# Llamada al sistema para leer un número
	syscall		# Realizamos la llamada al sistema para que se ejecute
	move $a1, $v0   # Movemos el número leído a $a1 para no perderlo y enviarlo como argumento
	
	sb $a1, letra1	# Guardamos en el segmento de datos el primer carácter
			# Para luego imprimirlo como cadena
	
	# Solicitamos el segundo entero ASCII
	
	li $v0, 4 		# Código del sistema para imprimir una cadena (print_string)
	la $a0, cadIntro2	# Cargamos en $a0 la cadena a imprimir
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	li $v0, 5	# Llamada al sistema para leer un número
	syscall		# Realizamos la llamada al sistema para que se ejecute
	move $a2, $v0   # Movemos el número leído a $a2 para no perderlo y enviarlo como argumento
	
	sb $a2, letra2	# Guardamos en el segmento de datos el segundo carácter
			# Para luego imprimirlo como cadena
	
	# Solicitamos el tercero entero ASCII
	
	li $v0, 4 		# Código del sistema para imprimir una cadena (print_string)
	la $a0, cadIntro2	# Cargamos en $a0 la cadena a imprimir
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	li $v0, 5	# Llamada al sistema para leer un número
	syscall		# Realizamos la llamada al sistema para que se ejecute
	move $a3, $v0   # Movemos el número leído a $a3 para no perderlo y enviarlo como argumento
	
	sb $a3, letra3 	# Guardamos en el segmento de datos el tercer carácter
			# Para luego imprimirlo como cadena
	
	la $a0, cadLeida	# Cargamos en $a0 la dirección de memoria que tiene la 
				# cadena leída
	
	jal calcula_cosas # Llamamos a la subrutina
	
	move $t0, $v0		# Guardamos el 1 resultado en $t0
	move $t1, $v1		# Guardamos el 2 resultado en $t1
	
	lw $t3, ($sp)		# Desapilamos el 4 resultado en $t3
	addi $sp, $sp, 4	# Actualizamos la pila
	
	lw $t2, ($sp)		# Desapilamos el 3 resultado en $t2
	addi $sp, $sp, 4	# Actualizamos la pila
	
	# Imprimimos los resultados
	
	li $v0, 4 		# Código del sistema para imprimir una cadena (print_string)
	la $a0, cadResul1	# Cargamos en $a0 la cadena a imprimir
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	move $a0, $t0		# Movemos a $a0 el resultado
	li $v0, 1		# Código del sistema para imprimir un entero
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	li $v0, 4 		# Código del sistema para imprimir una cadena (print_string)
	la $a0, cadResul2	# Cargamos en $a0 la cadena a imprimir
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	move $a0, $t1		# Movemos a $a0 el resultado 
	li $v0, 1		# Código del sistema para imprimir un entero
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	li $v0, 4 		# Código del sistema para imprimir una cadena (print_string)
	la $a0, letra1		# Cargamos en $a0 la cadena a imprimir
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	li $v0, 4 		# Código del sistema para imprimir una cadena (print_string)
	la $a0, cadResul3	# Cargamos en $a0 la cadena a imprimir
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	move $a0, $t2		# Movemos a $a0 el resultado 
	li $v0, 1		# Código del sistema para imprimir un entero
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	li $v0, 4 		# Código del sistema para imprimir una cadena (print_string)
	la $a0, letra2		# Cargamos en $a0 la cadena a imprimir
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	li $v0, 4 		# Código del sistema para imprimir una cadena (print_string)
	la $a0, cadResul3	# Cargamos en $a0 la cadena a imprimir
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	move $a0, $t3		# Movemos a $a0 el resultado 
	li $v0, 1		# Código del sistema para imprimir un entero
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	li $v0, 4 		# Código del sistema para imprimir una cadena (print_string)
	la $a0, letra3		# Cargamos en $a0 la cadena a imprimir
	syscall			# Realizamos la llamada al sistema para que se ejecute
	
	li $v0, 10
	syscall
	
# Subrutina calcula_cosas
calcula_cosas:

	# Se inicializan los contadores
	li $v0, 0	# Contador de caracteres
	li $v1, 0	# Contador de primer carácter
	li $t0, 0	# Contador de segundo carácter
	li $t1, 0	# Contador de tercer carácter

	
	bucle:	
		lb $t2, ($a0)		# Se lee un carácter de la cadena 
		beqz $t2, fin  		# Si se ha llegado al último carácter de la cadena, se sale de la subrutina
		beq $t2, $a1, cuenta1	# Si es igual al primer carácter va al contador del primer carácter
		beq $t2, $a2, cuenta2	# Si es igual al segundo carácter va al contador del segundo carácter
		beq $t2, $a3, cuenta3	# Si es igual al tercer carácter va al contador del tercer carácter 
		addi $a0, $a0, 1	# Se actualiza el puntero para que apunte al carácter siguiente
		addi $v0, $v0, 1	# Se actualiza el contador de caracteres
		j bucle			# Se salta a bucle
		
	cuenta1:
		addi $v1, $v1, 1	# Se actualiza el contador del primer carácter
		addi $v0, $v0, 1	# Se actualiza el contador de caracteres
		addi $a0, $a0, 1	# Se actualiza el puntero para que apunte al carácter siguiente
		j bucle
		
	cuenta2:
		addi $t0, $t0, 1	# Se actualiza el contador del segundo carácter
		addi $v0, $v0, 1	# Se actualiza el contador de caracteres
		addi $a0, $a0, 1	# Se actualiza el puntero para que apunte al carácter siguiente
		j bucle
	
	cuenta3:
		addi $t1, $t1, 1	# Se actualiza el contador del tercer carácter
		addi $v0, $v0, 1	# Se actualiza el contador de caracteres
		addi $a0, $a0, 1	# Se actualiza el puntero para que apunte al carácter siguiente
		j bucle

	fin:
		# Antes de salir, apilamos $t0 y $t1 
		
		addi $sp, $sp, -4	# Apilamos el contador del 2 carácter
		sw $t0, ($sp)
		
		addi $sp, $sp, -4	# Apilamos el contador del 3 carácter
		sw $t1, ($sp)
		
		jr $ra			# Fin de la subrutina
