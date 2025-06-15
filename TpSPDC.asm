.8086
.model small
.stack 100h
.data

	Cartelito1 	db 	"Bienvenido al Adivinador de celebridades!", 0ah, 0dh
				db	"Intentare adivinar en que celebridad estas pensando", 0ah, 0dh
				db	"Veamos si puedo hacerlo...", 0ah, 0dh
				db  "1. Brad Pitt", 0ah, 0dh
				db  "2. Diego Peretti",0dh,0ah
				db  "3. Goku",0dh,0ah
				db	"4. Minnie Mouse",0dh,0ah
				db	"5. Paula Pareto",0dh,0ah
				db	"6. Leo Messi",0dh,0ah
				db	"7. Scarlet Johannsen",0dh,0ah
				db	"8. Mirta Legrand",0dh,0ah
				db	"9. Pikachu",0dh,0ah
				db	"10. Mafalda",0dh,0ah
				db  "Comenzamos??", 0ah, 0dh
				db  "S (si) / N (no)", 0ah, 0dh, 24h
	salto 		db 0dh, 0ah, 24h
	sino 		db 255 dup (24h), 0dh, 0ah, 24h

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

main proc
	mov ax, @data
	mov ds, ax

		call clearscreen

		mov dx, offset Cartelito1
		call impresion

		mov dx, offset sino
		call cargaEspecial

		mov dx, offset salto
		call impresion

		call preguntar1	

		call preguntar2

		call preguntar3

		call preguntar4

		call preguntar5

		call resultado

	mov ax, 4c00h
	int 21h

main endp
end
