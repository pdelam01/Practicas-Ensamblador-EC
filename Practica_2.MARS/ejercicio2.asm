.data # Zona de memoria de la máquina donde se almacenan los datos
num1: .word 3
num2: .word 7
salto: .asciiz "\n\n"
cad1: .asciiz "Introduzca el numero A: "
cad2: .asciiz "Introduzca el numero B: "
cad3: .asciiz "Introduzca el numero C: "
cad4: .asciiz "Introduzca el numero D: "
cadS1: .asciiz "El resultado de sumar A y B es: "
cadS2: .asciiz "El resultado de restar C y D es: "
cadS3: .asciiz "El resultado de sumar A, B, C Y D es: "
cadM4: .asciiz "El resultado de elevar A al cuadrado es: "
cadD5: .asciiz "Desplazamiento de A a la izquierda 3 veces: "
cadD6: .asciiz "El resto de dividir 7 entre 3 es: "

.globl main # Directiva de etiqueta global
.text
# Inicio del segmento de texto (instrucciones)
main: #etiqueta main

#Creacion de todas las variables y guardarlas
li $v0, 4
la $a0, cad1
syscall
#aqui guardamos
li $v0, 5
syscall
move $t0,$v0

li $v0, 4
la $a0, cad2
syscall
li $v0, 5
syscall
move $t1,$v0

li $v0, 4
la $a0, cad3
syscall
li $v0, 5
syscall
move $t2,$v0

li $v0, 4
la $a0, cad4
syscall
li $v0, 5
syscall
move $t3,$v0

#OPERACION A+B------------------------------------------------------------------
add $t4, $t0, $t1

li $v0, 4
la $a0, cadS1
syscall

li $v0, 1
move $a0, $t4
syscall

li $v0, 4
la $a0, salto
syscall

#OPERACION C-D-----------------------------------------------------------
sub $t5, $t2, $t3

li $v0, 4
la $a0, cadS2
syscall

li $v0, 1
move $a0, $t5
syscall 

li $v0, 4
la $a0, salto
syscall

#OPERACION A+B+C+D----------------------------------------------------------
add $t6, $t2, $t3
add $t7, $t4, $t6

li $v0, 4
la $a0, cadS3
syscall

li $v0, 1
move $a0, $t7
syscall

li $v0, 4
la $a0, salto
syscall

#OPERACION 'A' AL CUADRADO----------------------------------------------------
mul $t8, $t0, $t0

li $v0, 4
la $a0, cadM4
syscall

li $v0, 1
move $a0, $t8
syscall

li $v0, 4
la $a0, salto
syscall

#DESPLAZAMIENTO A ALA IZQUIERDA A----------------------------------------------------
sll $t9, $t0, 3

li $v0, 4
la $a0, cadD5
syscall

li $v0, 1
move $a0, $t9
syscall

li $v0, 4
la $a0, salto
syscall

#Leer los dos enteros del segmento de datos e imprimir el resto de dividir 7/3----------------------------
lw $t8, num1
lw $t9, num2
syscall

div $t9, $t8
mfhi $t6

li $v0, 4
la $a0, cadD6
syscall

li $v0, 1
move $a0, $t6
syscall

li $v0, 4
la $a0, salto
syscall


li $v0,10 # Llamada al sistema de tipo "exit"
syscall
