.model small
.stack 100h
.8086
.data
	a1 db 100 dup (?)
	msg1 db 10,13,"Enter string: $"

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

	mov si, offset a1
	mov di, offset a1
	add di, ax
	dec di
	mov cx, ax
	shr cx, 1

main__rev:
	mov ah, [si]
	mov al, [di]
	mov [di], ah
	mov [si], al
	inc si
	dec di
	loop main__rev

	mov ax, offset a1
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
