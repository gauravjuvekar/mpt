.model small
.stack 100h
.8086
.data
	a1 db 100 dup (?)
	msg1 db 10,13,"Enter string: $"
	msg2 db 10,13,"Length =: $"


.code
include tty.asm

main proc
	mov ax, ds
	mov es, ax

	mov ax, offset msg1
	push ax
	call puts

	mov ax, offset a1
	push ax
	call gets

	mov di, offset a1
	mov cx, 0ffffh

	mov al, '$'
	repnz scasb
	sub di, offset a1
	dec di

	mov ax, offset msg2
	push ax
	call puts

	push di
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
