.model small
.stack 100h
.8086
.data
	a1 db 5 dup (?)
	LEN EQU 4

	msg1 db 10,13,"Enter 4 array bytes: $"
	msg2 db 10,13,"Enter byte to search: $"
	msg3 db 10,13,"Found at : 0x$"
	msg4 db 10,13,"Not found$"

.code
include tty.asm

main proc
	mov ax, ds
	mov es, ax
	cld

	mov ax, offset msg1
	push ax
	call puts
	mov cx, LEN
	mov di, offset a1
main__inp:
	call scn2x
	stosb
	loop main__inp

	mov ax, offset msg2
	push ax
	call puts
	call scn2x

	mov di, offset a1
	mov cx, LEN
	inc cx
	repne scasb
	mov ax, offset msg4
	sub di, offset a1

	cmp di, LEN
	ja main__not_found
	mov ax, offset msg3
main__not_found:
	push ax
	call puts
	cmp di, LEN
	ja main__end
	push di
	mov bx, 0004h
	push bx
	call prt_x

main__end:
	ret
endp main
.startup
	mov ax, @data
	mov ds, ax

	call main
	mov ax, 4c00h
	int 21h
end
