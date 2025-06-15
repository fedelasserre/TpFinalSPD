.8086
.model small
.stack 100h
.data

	Cartelito1 	db 	"Bienvenido al Adivinador de celebridades!", 0ah, 0dh
				db	"Intentare adivinar en que celebridad estas pensando", 0ah, 0dh
				db	"Veamos si puedo hacerlo...", 0ah, 0dh
				db  "1. Brad Pitt				2. Mauricio Macri", 0ah, 0dh
				db  "3. Demi Lovato				4. Mickey Mouse", 0ah, 0dh
				db  "5. Bugs Bunny				6. Minnie Mouse", 0ah, 0dh
				db  "7. Tom Holland				8. Meryl Streep", 0ah, 0dh
				db  "9. Tony Todd				10. Leo Messi", 0ah, 0dh
				db  "11. Emma Stone				12. Pikachu", 0ah, 0dh
				db  "13. El Pato Lucas			14. Goku", 0ah, 0dh
				db  "15. Lali Esposito			16. Cristiano Ronaldo", 0ah, 0dh
				db  "17. Cristina Kirschner			18. Pablo Alboran", 0ah, 0dh
				db  "19. Javier Milei			20. Kylian Mbappe", 0ah, 0dh
				db  "Comenzamos??", 0ah, 0dh
				db  "S (si) / N (no)", 0ah, 0dh, 24h
	salto 		db 0dh, 0ah, 24h
	sino 		db 255 dup (24h), 0dh, 0ah, 24h

.code

extrn impresion:proc
extrn carga:proc
extrn cargaEspecial:proc

main proc
	mov ax, @data
	mov ds, ax

		lea bx, Cartelito1
		call impresion

		lea bx, salto
		call impresion
		lea bx, salto
		call impresion

		lea bx, sino
		call cargaEspecial

	mov ax, 4c00h
	int 21h

main endp
end