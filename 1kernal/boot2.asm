section .data
    msgBack db ' ', 0x00

section .text
    [bits 16]
    org 0x7C00
start:
    mov ax, cs
    mov ds, ax
    mov ax, 0xB800
    mov es, ax
    mov ah, byte [msgBack]
    mov cx, 0x7D0
    mov di, 0
draw:
    mov word [es:di], ax
    add di, 2
    dec cx
    jnz draw
mov di, 0
mov ecx, 100

call read 

read:
    mov ax, 0x0800
    mov es, ax
    mov bx, 0

    mov ah, 2
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0x80

    int 0x13
    jc read
jmp 0x8000


; mov byte [es:di], dl
; inc di
; mov byte [es:di], 0x1E

    ; loop write



end:
    times 510-($-$$) db 0
    dw 0xAA55
