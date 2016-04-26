.model small
.stack 100h
.8086
.data
	a1 db 100 dup (?)
	msg1 db 10,13,"Enter string: $"
	msg2 db 10,13,"String is a palindrome$"
	msg3 db 10,13,"String is not a palindrome$"


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
	mov cx, ax

	mov si, offset a1
	mov di, offset a1
	add di, cx
	dec di
	shr cx, 1
	jz main__palindrome

main__loop:
	mov al, [si]
	cmp al, [di]
	jnz main__not_palindrome
	inc si
	dec di
	loop main__loop
main__palindrome:
	mov bx, offset msg2
	jmp main__end
main__not_palindrome:
	mov bx, offset msg3
main__end:
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
