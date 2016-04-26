.model small
.stack 100h
.8086
.data
	a1 db 100 dup (?)
	msg1 db 10,13,"Enter string: $"
	msg2 db 10,13,"UPPER case: ",10,13,"$"


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
	mov cx, ax; strlen(a1)

	; Get the differing bit
	mov bl, 'a'
	xor bl, 'A'
	not bl

	mov si, offset a1
	mov di, offset a1
	cld
main__loop:
	lodsb
	cmp al, 'A'
	jb main__notchar
	cmp al, 'Z'
	jb main__char
	cmp al, 'a'
	jb main__notchar
	cmp al, 'z'
	jb main__char
main__char:
	and al, bl
main__notchar:
	stosb
	loop main__loop

	mov ax, offset msg2
	push ax
	call puts

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
