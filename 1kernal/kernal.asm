org 0x8000

mov ax, 0xB800
mov es, ax


mov di, -2
mov ah, 0x09

mov al, 'K'
call setplace
mov al, 'E'
call setplace
mov al, 'R'
call setplace
mov al, 'N'
call setplace
mov al, 'A'
call setplace
mov al, 'L'
call setplace
call end

setplace:
    add di, 2
    mov [es:di], ax
    ret
end:
jmp $
times 512-($-$$) db 0x00
