.model small
.stack 100h
.8086
.data
	msg1 db 10,13,"Enter the no 1: 0x$"
	msg2 db 10,13,"Enter the no 2: 0x$"
	eol db 10,13,"$"
	msg_hex db "0x$"
	msg_sub db " - $"
	msg_equ db " = $"

.code
	mov ax, @data
	mov ds, ax


	mov ax, offset msg1
	push ax
	call puts
	call scn4x
	mov si, ax
	call scn4x
	mov di, ax

	mov ax, offset msg2
	push ax
	call puts
	call scn4x
	mov cx, ax
	call scn4x
	mov dx, ax

	; sub 8 lower
	mov ax, offset eol
	push ax
	call puts

	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, di
	mov ah, al
	push ax
	mov ax, 2
	push ax
	call prt_x

	mov ax, offset msg_sub
	push ax
	call puts
	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, dx
	mov ah, al
	push ax
	mov ax, 2
	push ax
	call prt_x

	mov ax, di
	mov bx, dx
	sub al, bl
	mov ah, al
	push ax
	mov ax, 2
	push ax

	mov ax, offset msg_hex
	push ax
	mov ax, offset msg_equ
	push ax
	call puts
	call puts
	call prt_x

	; sub 16 lower
	mov ax, offset eol
	push ax
	call puts

	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, di
	push ax
	mov ax, 4
	push ax
	call prt_x

	mov ax, offset msg_sub
	push ax
	call puts
	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, dx
	push ax
	mov ax, 4
	push ax
	call prt_x

	mov ax, di
	sub ax, dx
	push ax
	mov ax, 4
	push ax

	mov ax, offset msg_hex
	push ax
	mov ax, offset msg_equ
	push ax
	call puts
	call puts
	call prt_x

	; sub 32 lower
	mov ax, offset eol
	push ax
	call puts

	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, di
	push ax
	mov ax, 4
	push ax
	mov ax, si
	push ax
	mov ax, 4
	push ax
	call prt_x
	call prt_x

	mov ax, offset msg_sub
	push ax
	call puts
	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, dx
	push ax
	mov ax, 4
	push ax
	mov ax, cx
	push ax
	mov ax, 4
	push ax
	call prt_x
	call prt_x

	mov ax, di
	sub ax, dx
	push ax
	mov ax, si
	sbb ax, cx
	mov bx, 4
	push bx
	push ax
	push bx

	mov ax, offset msg_hex
	push ax
	mov ax, offset msg_equ
	push ax
	call puts
	call puts
	call prt_x
	call prt_x

	
	mov ax, 4c00h
	int 21h
;Library Function
scn2x  proc
	push bx
	push cx

    mov ch, 2; characters to scan
    mov cl, 4; bits in a nibble
    mov bl, 0
scn2x__nibble:
	shl bl, cl
    mov ah, 01h
    int 21h

    cmp al, 'A'
    jb scn2x__digit
    sub al, 07h; Difference between 'A' and '9'
scn2x__digit:
	sub al, '0'
    add bl, al
    dec ch
    jnz scn2x__nibble

    mov al, bl
	mov ah, 00h
	pop cx
	pop bx
    ret
scn2x endp


scn4x proc
	push bx
	push cx

    mov ch, 4; characters to scan
    mov cl, 4; bits in a nibble
    mov bl, 0
scn4x__nibble:
	shl bx, cl
    mov ah, 01h
    int 21h

    cmp al, 'A'
    jb scn4x__digit
    sub al, 07h; Difference between 'A' and '9'
scn4x__digit:
	sub al, '0'
    add bl, al
    dec ch
    jnz scn4x__nibble

    mov ax, bx
	pop cx
	pop bx
    ret
scn4x endp


prt_x proc; (data_16, chars_16)
	push bp
	mov bp, sp
	push bx
	push cx
	push dx

	mov cl, 4; bits in a nibble
	mov bx, [bp + 6]
	mov ax, [bp + 4]
	mov ch, al; chars to print

prt_x__nibble:
	rol bx, cl
	mov dl, bl
    and dl, 0fh
    cmp dl, 0Ah
    jb prt_x__digit
    add dl, 7; Difference between 'A' and '9'
prt_x__digit:
	add dl, '0'
    mov ah, 02h
    int 21h
    dec ch
    jnz prt_x__nibble

	pop dx
	pop cx
	pop bx
	pop bp
    ret 4
prt_x endp


puts proc; (string address)
	push bp
	mov bp, sp
	push dx
	push si

	mov dx, [bp + 4]
	mov ah, 09h
	int 21h

	pop si
	pop dx
	pop bp
	ret 2
endp puts

putch proc; (char8 lower)
	push bp
	mov bp, sp
	push dx

	mov dx, [bp + 4]
	mov ah, 02h
	int 21h

	pop dx
	pop bp
	ret 2
endp putch

getch proc
	mov ah, 01h
	int 21h
	ret
endp getch

gets proc; (dest address)
	push bp
	mov bp, sp
	push di
	push cx
	pushf

	mov cx, 0
	mov di, [bp + 4]
	cld

gets__loop:
	mov ah, 01h
	int 21h
	cmp al, 0dh
	jz gets__loop_end
	stosb
	inc cx
	jmp gets__loop
gets__loop_end:
	mov al, '$'
	stosb

	mov ax, cx
	popf
	pop cx
	pop di
	pop bp
	ret 2
endp gets
end

