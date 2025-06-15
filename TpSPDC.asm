.8086
.model small
.stack 100h
.data

    Cartelito1     db     "Bienvenido al Adivinador de celebridades!", 0ah, 0dh
                db    "Intentare adivinar en que celebridad estas pensando", 0ah, 0dh
                db    "Veamos si puedo hacerlo...", 0ah, 0dh
                db  "1. Brad Pitt                2. Mauricio Macri", 0ah, 0dh
                db  "3. Demi Lovato                ", 0ah, 0dh
                db  "Comenzamos??", 0ah, 0dh
                db  "S (si) / N (no)", 0ah, 0dh, 24h
    salto         db 0dh, 0ah, 24h
    sino         db 255 dup (24h), 0dh, 0ah, 24h

.code

extrn impresion:proc
extrn cargaEspecial:proc
extrn preguntar1:proc
extrn preguntar2:proc
extrn preguntar3:proc
extrn resultado:proc

main proc
    mov ax, @data
    mov ds, ax

        mov dx, offset Cartelito1
        call impresion

        mov dx, offset sino
        call cargaEspecial

        lea bx, salto
        call impresion

        call preguntar1

        call preguntar2

        call preguntar3

        call resultado



    mov ax, 4c00h
    int 21h

main endp
end