section .data
msgBack db ' ', 0x8E

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
    mov ax, word [msgBack] ; h 부분으로 바꿔서 수정
    mov cx, 0x7D0
; 사실은 [] 대괄호가 주소 값을 의미하는 연산자였다.

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
    mov cx, 0000
    call color
    call exit

color:
    inc di
    mov byte [es:di], 0x1E
    inc di
    ret
exit:



; mov byte [es:di], dl
; inc di
; mov byte [es:di], 0x1E

    ; loop write

hlt

end:
    times 510-($-$$) db 0
    dw 0xAA55
