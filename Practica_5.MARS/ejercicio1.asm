	.data
	
num:		.asciiz "Introduzca 6 numeros: "
cadSuma:	.asciiz "La suma total resulta: "
cadProduct:	.asciiz "El producto total resulta: "
cadResta: 	.asciiz "La resta total resulta: "

	.globl main
	.text
	
main:
	li $v0,4
	la $a0, num
	syscall
	
	li $v0,5		#guardamos los 6num en 4 $a y 2 en pila
	syscall
	move $a0,$v0
	
	li $v0,5
	syscall
	move $a1,$v0
	
	li $v0,5
	syscall
	move $a2,$v0
	
	li $v0,5
	syscall
	move $a3,$v0
	
	li $v0,5
	syscall
	addi $sp, $sp, -1	#hacemos "sitio" en la pila decrementando $sp
	#li $t0, $v0	(no necesario ahora)     	#ponemos en $t0 el dato que queremos apilar
	sb $v0, ($sp)	 	#almacenamos $t0 en el espacio reservado
	
	li $v0,5
	syscall
	addi $sp, $sp, -1
	sb $v0, ($sp)
	
	jal subrutina_1	
	move $t0,$v0		
	move $t1, $v1
	lw $t3, ($sp)		# Desapilamos el 3 resultado en $t3
	addi $sp, $sp, 4
	
	li $v0, 4
	la $a0, cadSuma
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
				
	li $v0, 4
	la $a0, cadProduct
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	
	li $v0, 4
	la $a0, cadResta
	syscall
	
	li $v0,1
	move $a0, $t3
	syscall
	
	li $v0, 10	#en cuanto acabe la subrutina, aqui se acaba el programa
	syscall
	
	subrutina_1:
		add $v0, $a0, $a1
		add $v0, $v0, $a2
		add $v0, $v0, $a3
		
		lb $t0, ($sp)		 #cargamos de la pila el último byte apilado
		add $v0, $v0, $t0
		addi $sp, $sp, 1	 #actualizamos el puntero de pila 
		
		lb $t1, ($sp)
		add $v0, $v0, $t1
		addi $sp, $sp, 1
		
		
		mul $v1, $a0, $a1
		mul $v1, $v1, $a2
		mul $v1, $v1, $a3		
		mul $v1, $v1, $t0
		mul $v1, $v1, $t1
		
		sub $t2, $a0, $a1
		sub $t2, $t2, $a2
		sub $t2, $t2, $a3
		sub $t2, $t2, $t0
		sub $t2, $t2, $t1
		
		addi $sp, $sp, -4
		sw $t2, ($sp)
		
		jr $ra
	
	
