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
	pregunta1		db "Es una mujer?",0dh,0ah,24h
	personajes		db "1","2","3",0dh,0ah,24h
	pregunta2 		db "Es argentino?",0dh,0ah,24h
	pregunta3 		db "Es actor?",0dh,0ah,24h
	textoFinal		db "Tu personaje es el numero: ",0dh,0ah
	personajeAscii	db "000",0dh,0ah,24h
	textoError		db "No pudimos encontrar tu personaje :(",0dh,0ah,24h

	
.code

public regToAscii
public impresion
public cargaEspecial
public preguntar1
public preguntar2
public preguntar3
public resultado
public respuestas

	impresion proc 
        push ax
        mov ah,9
        int 21h
        pop ax
        ret
	impresion endp

	regtoascii proc	;recibe en bx el offset de una variable de 3 bytes
					;el numero a convertir por dl
        push ax
        push dx

		add bx,2
		xor ax,ax
		mov al, dl
		mov dl, 10
		div dl
		add [bx],ah

		xor ah,ah
		dec bx
	    div dl
		add [bx],ah

		xor ah,ah
		dec bx
	    div dl
		add [bx],ah

        pop dx
        pop ax

        ret
    regtoascii endp
 ;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

	respuestas proc
			mov ah, 1
			int 21h
			mov dx, offset salto 
			call impresion
		ret
	respuestas endp

	preguntar1 proc

		mov dx, offset pregunta1
		call impresion

		call respuestas
		cmp al, 'S'
		je esMujer
		cmp al, 'N'
		je noEsMujer

		esMujer:
			mov al, 0
			mov personajes[0],al 
			mov personajes[1],al 
			jmp finPreguntar1

		noEsMujer:
			mov al, 0
			mov personajes[2],al
			jmp finPreguntar1

		finPreguntar1:

		ret 
	preguntar1 endp

	preguntar2 proc
		
		mov dx, offset pregunta2
		call impresion

		call respuestas
		cmp al, 'S'
		je esArgentino
		cmp al, 'N'
		je noEsArgentino

		esArgentino:
			mov al, 0
			mov personajes[0],al 
			mov personajes[2],al 
			jmp finPreguntar2

		noEsArgentino:
			mov al, 0
			mov personajes[1],al
			jmp finPreguntar2
			 
		finPreguntar2:
		
		ret
	preguntar2 endp

	preguntar3 proc

		mov dx, offset pregunta3
		call impresion

		call respuestas
		cmp al, 'S'
		je esActor
		cmp al, 'N'
		je noEsActor

		esActor:
			mov al, 0
			mov personajes[1],al
			mov personajes[2],al 
			jmp finPreguntar3

		noEsActor:
			mov al, 0
			mov personajes[1],al
			jmp finPreguntar3
			 
		finPreguntar3:
		
		ret
	preguntar3 endp

	resultado proc 
		mov si,0

		compara:
			cmp si, 3
			je finalError
			cmp personajes[si],0 
			jne final 
			inc si 
			jmp compara

		final:
			mov bx, offset personajeAscii
			mov dl, byte ptr[si]
			call regtoascii

			mov dx, offset textoFinal
			call impresion
			
			jmp finProceso

		finalError:
			mov dx, offset textoError
			call impresion
		finProceso:
	ret 
	resultado endp
end
