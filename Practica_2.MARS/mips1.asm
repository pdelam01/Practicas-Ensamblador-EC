.data
# comienzo del segmento de datos
cad1: .asciiz "Introduzca un número" #Forma de declarar una cadena
cad2: .asciiz "El resultado es: " #Forma de declarar una cadena
.globl main # la etiqueta main es global
.text # comienzo del segmento de texto (instrucciones)
main:
# Comienza la función main
li $v0, 4
la $a0, cad1
syscall # código de la llamada print_string
#imprime la cadena que está en la dirección $a0
li $v0, 5
syscall # código de la llamada read_int
# ahora se introduce un número en la consola
move $t0,$v0 # se guarda el contenido de $v0 (el número) en $t1
mul $t1,$t0,$t0 # se eleva al cuadrado
li $v0, 4
la $a0, cad2
syscall
# código de la llamada print_string
#imprime la cadena que está en la dirección $a0
li $v0,1
# código de llamada print_int
move $a0, $t1 # $a0 = número que se quiere imprimir
syscall
# se realiza la llamada
li $v0, 10
syscall
# código de llamada exit
# llamada al sistema