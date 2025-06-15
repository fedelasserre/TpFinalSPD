.8086
.model small
.stack 100h
.data

	Cartelito1 	db 	"Bienvenido al Adivinador de celebridades!", 0ah, 0dh
				db	"Intentare adivinar en que celebridad estas pensando", 0ah, 0dh
				db	"Veamos si puedo hacerlo...", 0ah, 0dh, 24h
	salto 		db 0dh, 0ah, 24h

.code

extrn impresion:proc
extrn carga:proc

main proc
	mov ax, @data
	mov ds, ax

		lea bx, Cartelito1
		call impresion

		lea bx, salto
		call impresion
		lea bx, salto
		call impresion

	mov ax, 4c00h
	int 21h

main endp
end