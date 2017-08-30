section .data
msgBack db ' ', 0x00
section .text
[org 0]
[bits 16]
    ; SEGMENT 지정이 아니고,
    ; ip의 위치가  해당 위치로 오게 됐을 때
    ; start레이블로 이동해라
    jmp 0x07C0:start
start:
    mov ax, cs
    mov ds, ax

    mov ax, 0xB800
    mov es, ax
    mov di, 0
    mov ah, byte [msgBack] ; h 부분으로 바꿔서 수정
    mov cx, 0x7D0

draw:
    mov word [es:di], ax
    add di, 2
    dec cx
    jnz draw

mov di, 0
mov ecx, 100

write:
    mov byte [es:di], 'L'
    call color
    mov byte [es:di], 'O'
    call color
    mov byte [es:di], 'A'
    call color
    mov byte [es:di], 'D'
    call color
    mov byte [es:di], 'I'
    call color
    mov byte [es:di], 'N'
    call color
    mov byte [es:di], 'G'
    call color

    call end

color:
    inc di
    mov byte [es:di], 0x1E
    inc di
    ret
hlt
; mov byte [es:di], dl
; inc di
; mov byte [es:di], 0x1E

    ; loop write



end:
    times 510-($-$$) db 0
    dw 0xAA55
