.8086
.model small
.stack 100h
.data
	bradpitt		db  "Brad Pitt", 0ah, 0dh, 24h
	diegoperetti	db  "Diego Peretti",0dh,0ah, 24h
	goku			db  "Goku",0dh,0ah, 24h
	minnie			db	"Minnie Mouse",0dh,0ah, 24h
	paulapareto		db	"Paula Pareto",0dh,0ah, 24h
	messi			db	"Leo Messi",0dh,0ah, 24h
	scarlet			db	"Scarlet Johannsen",0dh,0ah, 24h
	mirthalegrand	db	"Mirta Legrand",0dh,0ah, 24h
	pikachu			db	"Pikachu",0dh,0ah, 24h
	mafalda			db	"Mafalda",0dh,0ah, 24h
	textoError		db "No pudimos encontrar tu personaje :(",0dh,0ah,24h
	salto 			db 0dh, 0ah, 24h
	sino 			db 255 dup (24h), 0dh, 0ah, 24h

.code

extrn impresion:proc
extrn cargaEspecial:proc
extrn preguntar1:proc
extrn preguntar2:proc
extrn preguntar3:proc
extrn preguntar4:proc
extrn preguntar5:proc
extrn resultado:proc
extrn clearscreen:proc
extrn cargaEspecial2:proc
extrn leer:proc

main proc
	mov ax, @data
	mov ds, ax

		call clearscreen

		call leer

		mov dx, offset sino
		call cargaEspecial

		call clearscreen

		call preguntar1	

		call preguntar2

		call preguntar3

		call preguntar4

		call preguntar5

		call resultado

		cmp si,1
		je personaje1

		cmp si,2
		je personaje2

		cmp si,3
		je personaje3

		cmp si,4
		je personaje4

		cmp si,5
		je personaje5

		cmp si,6
		je personaje6

		cmp si,7
		je personaje7

		cmp si,8
		je personaje8

		cmp si,9
		je personaje9

		cmp si,10
		je personaje10

		cmp si,11
		je finalError

		personaje1:
			mov dx, offset bradpitt
			call impresion
			jmp final
		personaje2:
			mov dx, offset diegoperetti
			call impresion
			jmp final
		personaje3:
			mov dx, offset goku
			call impresion
			jmp final
		personaje4:
			mov dx, offset minnie
			call impresion
			jmp final
		personaje5:
			mov dx, offset paulapareto
			call impresion
			jmp final
		personaje6:
			mov dx, offset messi
			call impresion
			jmp final
		personaje7:
			mov dx, offset scarlet
			call impresion
			jmp final
		personaje8:
			mov dx, offset mirthalegrand
			call impresion
			jmp final
		personaje9:
			mov dx, offset pikachu
			call impresion
			jmp final
		personaje10:
			mov dx, offset mafalda
			call impresion
			jmp final
		
		finalError:
			mov dx, offset textoError
			call impresion
			jmp final
	final:
	mov ax, 4c00h
	int 21h

main endp
end
