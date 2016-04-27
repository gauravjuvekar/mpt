.model small
.stack 100h
.8086
.data
	a1 db 4 dup (?)
	a2 db 4 dup (?)
	LEN EQU 4

	msg1 db 10,13,"Enter 4 array bytes: $"
	msg2 db 10,13,"Contents exchanged",10,13,"$"
	msg_eol db 10,13,"$"

.code
	mov ax, @data
	mov ds, ax
	mov es, ax
	cld
	mov ax, offset msg1
	push ax
	call puts
	mov cx, LEN
	mov di, offset a1
main__inp1:
	call scn2x
	stosb
	loop main__inp1

	mov ax, offset msg1
	push ax
	call puts
	mov cx, LEN
	mov di, offset a2
main__inp2:
	call scn2x
	stosb
	loop main__inp2

	mov si, offset a1
	mov di, offset a2
	mov cx, LEN

main__xchg:
	mov ah, [di]
	mov al, [si]
	mov [di], al
	mov [si], ah
	inc si
	inc di
	loop main__xchg

	mov ax, offset msg2
	push ax
	call puts

	mov bx, 0002h
	mov si, offset a1
	mov cx, LEN
main__prt1:
	lodsb
	mov ah, al
	push ax
	push bx
	call prt_x
	loop main__prt1

	mov ax, offset msg_eol
	push ax
	call puts

	mov si, offset a2
	mov cx, LEN
main__prt2:
	lodsb
	mov ah, al
	push ax
	push bx
	call prt_x
	loop main__prt2

	
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

