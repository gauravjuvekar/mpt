.model small
.stack 100h
.8086
.data
	msg1 db 10,13,"Enter number :0x$"
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

	mov ax, 0001h
	mov bx, 0000h
	mov cx, 0004h
main_lp:
	push ax
	mov ax, OFFSET eol
	push ax
	call puts
	pop ax

	add ax, bx
	xchg ax, bx

	push ax
	push ax
	push cx
	call prt_x
	pop ax
	cmp ax, num
	jb main_lp

	ret
endp main
.startup
	mov ax, @data
	mov ds, ax

	call main
	mov ax, 4c00h
	int 21h
end
