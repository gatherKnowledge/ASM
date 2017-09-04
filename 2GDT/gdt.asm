;커널, kernel.asm

;*********************************************
;   16비트 엔트리 ( 부트로더 -> 이곳 점프 )
;*********************************************
org     0x8000

; GDT 등록
xor     ax, ax
lgdt    [gdtr]
cli
mov     eax, cr0
or      eax, 1
mov     cr0, eax

jmp     $+2
nop
nop 

jmp     0x08:Entry32

;*********************************************
;   32비트 엔트리
;*********************************************
[bits   32]
Entry32:
    ; 세그먼트 레지스터 초기화
    mov     bx, dataDescriptor
    mov     ds, bx
    mov     es, bx
    mov     fs, bx
    mov     gs, bx
    mov     ss, bx
    xor     esp, esp
    mov     esp, 0x9FFFF

    ; es 레지스터에 비디오 디스크립터 저장
    mov     ax, 0x18
    mov     es, ax

    ; 문자 출력
    mov     ah, 0x09
    mov     al, 'P'
    mov     [es:0x0000], ax
    mov     al, 'r'
    mov     [es:0x0002], ax
    mov     al, 'o'
    mov     [es:0x0004], ax
    mov     al, 't'
    mov     [es:0x0006], ax
    mov     al, 'e'
    mov     [es:0x0008], ax
    mov     al, 'c'
    mov     [es:0x000A], ax
    mov     al, 't'
    mov     [es:0x000C], ax

    jmp     $

gdtr:
    dw gdt_end - gdt -1 ;
    dd gdt
gdt:
; null descriptor
nullDescriptor equ 0x00
    dw 0
    dw 0
    db 0
    db 0
    db 0
    db 0
codeDescriptor equ 0x08
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x9A
    db 0xCF
    db 0x00
dataDescriptor equ 0x10
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 0x92
    db 0xCF
    db 0x00
videoDescriptor equ 0x18
    dw 0xFFFF
    dw 0x8000
    db 0x0B
    db 0x92
    db 0xCF
    db 0x00
gdt_end:

times 512-($-$$) db 0x00
