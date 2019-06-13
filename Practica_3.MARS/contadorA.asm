	.data #comienzo segmento de datos
	
cadena: .asciiz "Introduzca una cadena: "
cadenaLeida: .space 100
cadenaEscrita: .asciiz "El numero de a es: "
letra: .byte 'a'

	.globl main #declaracion etiqueta main como global
	.text 	    #Comienzo segmento texto
	
main: 
	li $v0, 4 #li supone el printf: llamada para imprimir cadena
	la $a0, cadena
	syscall
	
	lb $t3, letra
	
	li $v0, 8 		#llama al sitema para leer cadena (8 por que es String)
	la $a0, cadenaLeida	#almacenamos en cadenaLeida  a0 por direccion
	li $a1, 100		#especificamos tamanyo 100   a1 por longitud
	syscall
	
	li $t0, 0		#inicializamos contador longitud
	la $t1, cadenaLeida 	#apunta a la cadena leida, a la primera letra
	
   bucle: lb $t2, ($t1) 	#leemos la primera letra
   	  beq $t2, $zero, fin	#si es 0, finalizamos bucle
   	  
   	  addi $t1, $t1, 1 	#mover el puntero
   	  bne $t2, $t3, bucle
   	  addi $t0, $t0, 1	#sumar el contador
   	 	
   	  j bucle 
   
   fin: 
   	 li $v0, 4
   	 la $a0, cadenaEscrita	#imprimimos la cadena
   	 syscall
   	 
   	 li $v0, 1 
   	 move $a0, $t0 		#imprimimos resultado del contador 
   	 syscall
   	 
   	 li $v0, 10		#fin del main
   	 syscall
	
	
	  
	
