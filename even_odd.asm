.model small
.stack 100h
.8086
.data
	msg1 db 10,13,"Enter the no : 0x$"
	msg2 db 10,13,"Number is even$"
	msg3 db 10,13,"Number is odd$"

.code
include tty.asm

main proc
	mov ax, offset msg1
	push ax
	call puts
	call scn4x

	mov bx, offset msg3
	ror ax, 1
	jc main__even
	mov bx, offset msg2
main__even:
	push bx
	call puts
	ret
endp main
.startup
	mov ax, @data
	mov ds, ax

	call main
	mov ax, 4c00h
	int 21h
end
