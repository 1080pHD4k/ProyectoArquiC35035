.data
color_cuadricula:    .word 0x00000000  # Negro
color_num:     .word 0x00FF0000  # Rojo
color_inicial: .word 0x0000FF  # Azul
fondo:    .word 0x00FFFFFF  # Blanco
input_teclado: .word 0xffff0000
tamaño_celda:     .word 8
tamaño_cuadri:     .word 4
tablero_facil: 
    .byte 0, 0, 0, 4
    .byte 0, 0, 0, 0
    .byte 2, 0, 0, 3
    .byte 4, 1, 2, 0
celdas_tablero_facil:
    .byte 0, 0, 0, 1
    .byte 0, 0, 0, 0
    .byte 1, 0, 0, 1
    .byte 1, 1, 1, 0
tablero_medio:
    .byte 0, 0, 0, 3
    .byte 0, 4, 0, 0
    .byte 1, 0, 0, 4
    .byte 0, 0, 3, 0
celdas_tablero_medio:
    .byte 0, 0, 0, 1
    .byte 0, 1, 0, 0
    .byte 1, 0, 0, 1
    .byte 0, 0, 1, 0
tablero_dificil:
    .byte 0, 0, 0, 3
    .byte 0, 4, 0, 0
    .byte 0, 0, 3, 2
    .byte 0, 0, 0, 0
celdas_tablero_dificil:
    .byte 0, 0, 0, 1
    .byte 0, 1, 0, 0
    .byte 0, 0, 1, 1
    .byte 0, 0, 0, 0

.text
.globl main

main:
    lw $t0, color_cuadricula
    lw $t1, color_num
    lw $t2, fondo
    li $t3, 0x10008000
    li $t4, 32
    lw $t5, tamaño_celda
    lw $t6, tamaño_cuadri

    li $s3, 0       # Estado del input (si es 0 = valor, si es 1 = fila, si es 2 = columna)
    li $t7, 0
    li $t8, 1024

pintar_fondo:
    beq $t7, $t8, dibujar_grid
    sw $t2, 0($t3)
    addi $t3, $t3, 4
    addi $t7, $t7, 1
    j pintar_fondo

dibujar_grid:
    li $t3, 0x10008000

    li $a0, 8
    lw $a1, color_cuadricula
    jal dibujar_horizontal_linea
    li $a0, 16
    jal dibujar_horizontal_linea
    li $a0, 24
    jal dibujar_horizontal_linea

    li $a0, 8
    jal dibujar_vertical_linea
    li $a0, 16
    jal dibujar_vertical_linea
    li $a0, 24
    jal dibujar_vertical_linea

    # dibujar tablero
    jal ingresar_datos_iniciales

    j input_loop
    
ingresar_datos_iniciales:
    lw $t1, color_inicial

    # 41d
    li $s2, 4
    li $s0, 0  
    li $s1, 3   
    jal dibujar_num_sin_chequeo


    # 23a
    li $s2, 2
    li $s0, 2  
    li $s1, 0  
    jal dibujar_num_sin_chequeo

    # 33d
    li $s2, 3
    li $s0, 2 
    li $s1, 3   
    jal dibujar_num_sin_chequeo

    # 44a
    li $s2, 4
    li $s0, 3   
    li $s1, 0  
    jal dibujar_num_sin_chequeo

    # 14b
    li $s2, 1
    li $s0, 3   
    li $s1, 1
    jal dibujar_num_sin_chequeo

    # 24c
    li $s2, 2
    li $s0, 3  
    li $s1, 2 
    jal dibujar_num_sin_chequeo
    

input_loop:
    lw $t9, input_teclado
    lw $t8, 0($t9)
    beq $t8, 0, input_loop
    lw $a0, 4($t9)

	#verifica el input
    li $t7, 0
    beq $s3, $t7, manejo_valor_input
    li $t7, 1
    beq $s3, $t7, manejo_fila_input
    li $t7, 2
    beq $s3, $t7, manejo_col_input

    j input_loop


manejo_valor_input:
    li $t7, '1'
    beq $a0, $t7, set_val1
    li $t7, '2'
    beq $a0, $t7, set_val2
    li $t7, '3'
    beq $a0, $t7, set_val3
    li $t7, '4'
    beq $a0, $t7, set_val4
    j input_loop

set_val1:
    li $s2, 1
    li $s3, 1
    j input_loop

set_val2:
    li $s2, 2
    li $s3, 1
    j input_loop

set_val3:
    li $s2, 3
    li $s3, 1
    j input_loop

set_val4:
    li $s2, 4
    li $s3, 1
    j input_loop
    
#filas
manejo_fila_input:
    li $t7, '1'
    beq $a0, $t7, set_fila1
    li $t7, '2'
    beq $a0, $t7, set_fila2
    li $t7, '3'
    beq $a0, $t7, set_fila3
    li $t7, '4'
    beq $a0, $t7, set_fila4
    j input_loop

set_fila1:
    li $s0, 0
    li $s3, 2
    j input_loop

set_fila2:
    li $s0, 1
    li $s3, 2
    j input_loop

set_fila3:
    li $s0, 2
    li $s3, 2
    j input_loop

set_fila4:
    li $s0, 3
    li $s3, 2
    j input_loop


#columnas
manejo_col_input:
    li $t7, 'a'
    beq $a0, $t7, set_col1
    li $t7, 'b'
    beq $a0, $t7, set_col2
    li $t7, 'c'
    beq $a0, $t7, set_col3
    li $t7, 'd'
    beq $a0, $t7, set_col4
    j input_loop

set_col1:
    li $s1, 0
    j terminar_input

set_col2:
    li $s1, 1
    j terminar_input

set_col3:
    li $s1, 2
    j terminar_input

set_col4:
    li $s1, 3
    j terminar_input

terminar_input:
    jal dibujar_num_usuario
    li $s3, 0       # Reinicia el estado
    j input_loop

dibujar_num_sin_chequeo:
    li $t3, 0x10008000      # base de display
    li $t4, 32              # ancho pantalla
    lw $t5, tamaño_celda

    mul $t7, $s0, $t5
    addi $t7, $t7, 1
    mul $t8, $s1, $t5
    addi $t8, $t8, 2

    mul $t9, $t7, $t4
    add $t9, $t9, $t8
    sll $t9, $t9, 2
    add $t9, $t9, $t3

    beq $s2, 1, dibujar_uno
    beq $s2, 2, dibujar_dos
    beq $s2, 3, dibujar_tres
    beq $s2, 4, dibujar_cuatro
    
jr_ra:
    jr $ra

# dibujar en bitmap
dibujar_num_usuario:
    # Verificar si la celda esta ocupada
    la $t0, celdas_tablero_facil
    mul $t1, $s0, 4
    add $t1, $t1, $s1
    add $t0, $t0, $t1
    lb $t2, 0($t0)
    beq $t2, 1, jr_ra      # Si la celda esta ocupada, no dibujar

    lw $t1, color_num
    j dibujar_num_sin_chequeo

dibujar_uno:
    sw $t1, 4($t9)
    sw $t1, 132($t9)
    sw $t1, 260($t9)
    sw $t1, 388($t9)
    sw $t1, 516($t9)
    sw $t1, 644($t9)
    jr $ra

dibujar_dos:
    sw $t1, 0($t9)
    sw $t1, 4($t9)
    sw $t1, 8($t9)
    addi $t0, $t9, 128
    sw $t1, 8($t0)

    addi $t0, $t9, 256
    sw $t1, 0($t0)
    sw $t1, 4($t0)
    sw $t1, 8($t0)

    addi $t0, $t9, 384
    sw $t1, 0($t0)

    addi $t0, $t9, 512
    sw $t1, 0($t0)
    sw $t1, 4($t0)
    sw $t1, 8($t0)

    jr $ra

dibujar_tres:
    sw $t1, 0($t9)
    sw $t1, 4($t9)
    sw $t1, 8($t9)

    addi $t0, $t9, 128
    sw $t1, 8($t0)

    addi $t0, $t9, 256
    sw $t1, 0($t0)
    sw $t1, 4($t0)
    sw $t1, 8($t0)

    addi $t0, $t9, 384
    sw $t1, 8($t0)

    addi $t0, $t9, 512
    sw $t1, 0($t0)
    sw $t1, 4($t0)
    sw $t1, 8($t0)

    jr $ra


dibujar_cuatro:
    sw $t1, 0($t9)
    sw $t1, 8($t9)
    addi $t0, $t9, 128
    sw $t1, 0($t0)
    
    sw $t1, 8($t0)
    addi $t0, $t9, 256
    sw $t1, 0($t0)
    sw $t1, 4($t0)
    
    sw $t1, 8($t0)
    addi $t0, $t9, 384
    
    sw $t1, 8($t0)
    addi $t0, $t9, 512
    
    sw $t1, 8($t0)
    addi $t0, $t9, 640
    
    sw $t1, 8($t0)
    jr $ra

# Líneas horizontales
dibujar_horizontal_linea:
    mul $t6, $a0, $t4
    sll $t6, $t6, 2
    add $t7, $t3, $t6
    li $t8, 0
horizontal_loop:
    beq $t8, $t4, horizontal_fin
    sw $a1, 0($t7)
    addi $t7, $t7, 4
    addi $t8, $t8, 1
    j horizontal_loop
horizontal_fin:
    jr $ra

# Líneas verticales
dibujar_vertical_linea:
    li $t6, 0
vertical_loop:
    beq $t6, $t4, vertical_fin
    mul $t7, $t6, $t4
    add $t7, $t7, $a0
    sll $t7, $t7, 2
    add $t7, $t3, $t7
    sw $a1, 0($t7)
    addi $t6, $t6, 1
    j vertical_loop
vertical_fin:
    jr $ra
