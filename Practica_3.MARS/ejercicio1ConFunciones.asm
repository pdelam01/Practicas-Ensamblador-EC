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


#-------------------suma A+B
move $a0, $t0
move $a1, $t1
jal suma
move $t1, $v0

li $v0, 4
la $a0, cadS1
syscall
li $v0, 1
move $a0, $t1
syscall



#-------------------resta C-D
move $a1, $t2
move $a2, $t3
jal resta
move $t1,$v0

li $v0, 4
la $a0, cadS2
syscall
li $v0, 1
move $a0, $t1
syscall

li $v0, 10
syscall

li $v0, 10
syscall

suma:
add $t4, $a0, $a1
move $v0, $t4	
jr $ra

resta:
sub $t5,$a1, $a2
move $v0, $t5
jr $ra