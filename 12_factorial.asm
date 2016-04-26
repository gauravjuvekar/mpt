.model small
.stack 100h
.data
	msg1 db 10,13,"Enter number :0x$"
	msg2 db 10,13,"Result: 0x$"
	eol db 10,13,"$"
	num dw ?

.code
include tty.asm
main proc
	mov ax, OFFSET msg1
	push ax
	call puts

	call scn4x
	mov num, ax

	mov ax, OFFSET eol
	push ax
	call puts

	mov cx, num
	mov ax, 0001h
main__fact:
	mul cl
	dec cx
	jnz main__fact

	push ax
	mov ax, 0004h
	push ax
	call prt_x

	mov ax, 4c00h
	int 21h

endp main

.startup
	mov ax, @data
	mov ds, ax

	jmp main
end
