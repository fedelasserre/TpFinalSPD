.8086
.model small
.stack 100h

.data
	numeroReg 		db 0
	binario_en_reg 		db 0b
	multiplicador 		db 100, 10, 1
	divisor 		db 100, 10, 1
	salto 			db 0dh, 0ah, 24h
	salidaError 		db 'Lo ingresado no es un número hexadecimal', 0dh, 0ah, 24h
	EseNo   		db "Pedro, te dijimos si o no", 0dh, 0ah, 24h
	seguro 			db "Ahora, listo?", 0dh, 0ah, 24h
	cartel 			db  "S (si) / N (no)", 0ah, 0dh, 24h
	saltito 			db 0dh, 0ah, 24h

.code

public numeroReg
public imprimirSalto
public asciiToReg
public regToAscii
public binToAscii
public asciiToBin
public asciiToHexa
public impresion
public carga
public mayusculizador
public contarEspacios
public contarCaracteresSt
public cargaEspecial
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Funcion que imprimira un salto a la siguiente linea
	imprimirSalto proc
		mov ah, 9
		lea dx, salto
		int 21h
		ret
	imprimirSalto endp
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Funcion Para imprimir una variable o cadena

	impresion proc
		push ax
		push bx

		mov ah, 9
		lea dx, [bx]
		int 21h

		pop bx
		pop ax
		ret
	impresion endp
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Funcion de carga de caracteres

	carga proc
		push ax
		push bx

		proceso:
			mov ah, 1
			int 21h
			cmp al, 0dh
			je finCarga
			mov [bx], al
			inc bx
			jmp proceso


		finCarga:
			pop bx
			pop ax
			ret
	carga endp
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Funcion que pasa caracteres ascii a registro

	asciiToReg proc					; La función recibe en bx el offset de numeroAscii para devolverlo como registro
		;push ax
		push si
		push cx
		push bx

		mov ax, 0
		mov numeroReg, 0
		mov si, 0
		mov cx, 3

		proceso0:
			mov al, [bx]
			sub al, 30h
			mov dl, multiplicador[si]
			mul dl
			add numeroReg, al
			inc bx
			inc si
			mov ax, 0
			loop proceso0
		
		mov ah, 0
		mov al, numeroReg

		pop bx
		pop cx
		pop si
		;pop ax		
		ret
	asciiToReg endp
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Funcion que pasa caracteres de registro a ascii

	regToAscii proc					; La función recibe en bx el offset de numeroReg para devolverlo como ASCII
		push ax
		push si
		push cx
		push bx

        mov ah, 0					; Estas dos instrucciones las uso
        ;mov al, numeroReg			; solamente si no tengo el número en ax
		mov si, 0
		mov cx, 3

		proceso2:
			mov dl, divisor[si]
			div dl
			add al, 30h
			mov [bx], al
			mov al, ah
			mov ah, 0
			inc bx
			inc si
			loop proceso2

		pop bx
		pop cx
		pop si
		pop ax		
		ret
	regToAscii endp
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Funcion que pasa de binario a ascii

	binToAscii proc
		;mov al, binario_en_reg
		push ax
		push bx
		push cx
		mov cx, 8

		;mov binario_en_reg, al

		proceso1:
			shl al, 1				; Desplazo un bit a la izquierda
			jc esUno				; Si hay carry, el bit era 1 (si no, era 0)
			mov byte ptr [bx], '0'
			inc bx
			jmp siguiente

		esUno:
			mov byte ptr [bx], '1'
			inc bx

		siguiente:
			loop proceso1

		pop cx
		pop bx
		pop ax
		ret
	binToAscii endp
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Funcion que ahora, pasara de ascii a binario

	asciiToBin proc
		push bx
		push cx
		mov si, 0
		mov cx, 8

		proceso4:
			shl si, 1
			cmp byte ptr [bx], '1'
			jne siguiente0
			inc si

		siguiente0:
			inc bx
			loop proceso4

		mov ax, si
		mov ah, 0
		;mov binario_en_reg, al
		pop cx
		pop bx
		ret
	asciiToBin endp
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Funcion que pasara de ascii a hexa

	asciiToHexa proc
		push bx
		push dx

		mov numeroReg, 0
		mov ax, 0

		primerDigito:
			mov al, [bx]

			cmp al, '0'
			jb mostrarError          ; Si es menor que '0', error
			cmp al, '9'
			jbe esNumero

			cmp al, 'a'
			jb mostrarError          ; Si es menor que 'a', error
			cmp al, 'f'
			ja mostrarError          ; Si es mayor que 'f', error

			; Procesar letras a-f
			sub al, 'a'
			add al, 10               ; Convertir letras a-f a 10-15
			jmp calcularPrimerDigito

			esNumero:
				sub al, '0'              ; Convertir caracteres '0'-'9' a 0-9

			calcularPrimerDigito:
				mov dl, 16
				mul dl                   ; Multiplicar primer dígito por 16
				add numeroReg, al

		; Procesar segundo dígito
		segundoDigito:
			inc bx
			mov al, [bx]

			cmp al, '0'
			jb mostrarError
			cmp al, '9'
			jbe esNumero2

			cmp al, 'a'
			jb mostrarError
			cmp al, 'f'
			ja mostrarError

			; Procesar letras a-f
			sub al, 'a'
			add al, 10               ; Convertir letras a-f a 10-15
			jmp calcularSegundoDigito

		esNumero2:
			sub al, '0'              ; Convertir caracteres '0'-'9' a 0-9

		calcularSegundoDigito:
			add numeroReg, al        ; Sumar segundo dígito sin multiplicar


		finHexa:
			mov ah, 0
			mov al, numeroReg        ; Mover el resultado final a AX
			pop dx
			pop bx
			ret

		mostrarError:
			mov ah, 9
			lea dx, salidaError
			int 21h
			jmp finHexa

	asciiToHexa endp
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Funcion para contar espacios (Funciona aveces)

	contarEspacios proc
		push bx
		mov ax, 0

		proceso3:
			cmp byte ptr [bx], 24h
			je finContarEspacios
			cmp byte ptr [bx], 20h
			je contarEspacio
			inc bx
			jmp proceso3

		contarEspacio:
			inc ax
			inc bx
			jmp proceso3

		finContarEspacios:
			pop bx
			ret
	contarEspacios endp
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; Funcion que genera mayusculas en las letras de una cadena

    mayusculizador proc

        proceso5:

            cmp byte ptr [bx], 0dh
            je finConversion

            primeraCondicion:                       ; Etiqueta para evaluar la primera condición (mayor o igual que 'a')
                mov dl, [bx]
                cmp dl, 61h                         ; Comparo el carácter con 'a'
                jae segundaCondicion
                inc bx
                jmp proceso5

            segundaCondicion:                       ; Etiqueta para evaluar la segunda condición (menor o igual que 'z')
                mov dl, [bx]
                cmp dl, 7ah                         ; Comparo el carácter con 'z'
                jbe cambiarLetra
                inc bx
                jmp proceso5

            cambiarLetra:
                sub dl, 20h                         ; Si es letra minúscula, la paso a mayúscula
                mov [bx], dl                        ; Muevo la letra mayúscula a donde apunta BX
                inc bx
                jmp proceso5

        finConversion:
            ret
    mayusculizador endp
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Funcion que contara caracteres

    contarCaracteresSt proc
		push bp
		mov bp, sp
		push bx

        mov bx, [ss:bp+4]
        mov ax, 0

        procesoContar:
            cmp byte ptr [bx], 0dh
            je finProcesoContar
            inc ax
            inc bx
            jmp procesoContar

        finProcesoContar:
            pop bx
            pop bp
            ret 2
    contarCaracteresSt endp
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Funcion para recibir un si o un no
cargaEspecial proc
		push ax
		push bx

		proceso24:
			mov ah, 1
			int 21h
			cmp al, 's'
			je sigue
			cmp al, 'S'
			je sigue
			cmp al, 'n'
			je asustadoPotter
			cmp al, 'N'
			je asustadoPotter

			mov ah, 9
			mov dx, offset saltito
			int 21h

			mov ah, 9
			mov dx, offset EseNo
			int 21h

			mov ah, 9
			mov dx, offset cartel
			int 21h

		jmp proceso24

		asustadoPotter:
			mov ah, 9
			mov dx, offset saltito
			int 21h

			mov ah, 9
			mov dx, offset seguro
			int 21h

			mov ah, 9
			mov dx, offset cartel
			int 21h

		jmp proceso24

		sigue:

		finCarga24:
			pop bx
			pop ax
			ret
	cargaEspecial endp

end
