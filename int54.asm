; tsr54.asm - Interrupción 54h: limpia pantalla y lanza principal.com
.8086
.model tiny
.code
org 100h

start:
    jmp instalar

; --- FUNCION QUE SE EJECUTA CUANDO SE LLAMA A INT 54h ---
MiInt PROC FAR
    sti
    push ax
    push bx
    push cx
    push dx
    push ds
    push es
    push si
    push di
    pushf

    ; Asegura contexto de segmento válido
    mov ax, cs
    mov ds, ax
    mov es, ax

    ; LIMPIAR PANTALLA
    mov ah, 0
    mov al, 3      ; Modo texto 80x25
    int 10h

    ; EJECUTAR principal.com
    mov dx, offset NombreProg
    mov ah, 4Bh
    mov al, 0      ; EXEC
    int 21h

    popf
    pop di
    pop si
    pop es
    pop ds
    pop dx
    pop cx
    pop bx
    pop ax
    iret
MiInt ENDP

NombreProg db "principal.com", 0

; Variables para guardar la interrupción vieja (opcional)
OldOffset dw 0
OldSegment dw 0

instalar:
    mov ax, cs
    mov ds, ax
    mov es, ax

    ; Guardar vieja INT 54h
    mov ax, 3554h
    int 21h
    mov OldOffset, bx
    mov OldSegment, es

    ; Instalar nueva INT 54h
    mov dx, offset MiInt
    mov ax, 2554h
    int 21h

    ; Mostrar mensaje
    mov dx, offset cartel
    mov ah, 09h
    int 21h

    ; Dejar programa residente
    mov ax, offset fin - 100h
    add ax, 15
    shr ax, 4
    mov dx, ax
    mov ax, 3100h
    int 21h

cartel db "Interrupcion 54h instalada y residente!", 0dh, 0ah, '$'

fin label byte
end start
