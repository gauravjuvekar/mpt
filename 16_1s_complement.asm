.model small
.stack 100h
.8086
.data
	msg1 db 10,13,"Enter number :0x$"
	eol db 10,13,"$"

.code
include tty.asm
main proc
	mov ax, offset msg1
	push ax
	call puts

	call scn4x

	not ax
	mov bx, ax

	mov ax, offset eol
	push ax
	call puts

	push bx
	mov ax, 4
	push ax
	call prt_x

	ret
endp main
.startup
	mov ax, @data
	mov ds, ax

	call main
	mov ax, 4c00h
	int 21h
end
