.model small
.stack 100h
.8086
.data
	s1 db 100 dup (?)
	s2 db 100 dup (?)
	msg1 db 10,13,"Enter string 1: $"

.code
include tty.asm

main proc
	mov ax, ds
	mov es, ax

	mov ax, offset msg1
	push ax
	call puts

	mov ax, offset s1
	push ax
	call gets

	mov si, offset s1
	mov di, offset s2
	cld

main__loop:
	lodsb
	stosb
	cmp al, '$'
	jnz main__loop

	mov ax, offset s2
	push ax
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
