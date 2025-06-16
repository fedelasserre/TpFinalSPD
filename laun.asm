; launcher.asm
.8086
.model tiny
.stack 100h
.code
org 100h
start:
    ; Llama a INT 54h
    mov ah, 0
    int 54h

    mov ax, 4C00h
    int 21h
end start
