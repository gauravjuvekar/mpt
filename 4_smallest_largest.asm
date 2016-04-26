.model small
.stack 100h
.8086
.data
	a1 db 4 dup (?)
	LEN EQU 4

	msg1 db 10,13,"Enter 4 array bytes: $"
	msg2 db 10,13,"Smallest number is 0x$"
	msg3 db 10,13,"Largest number is 0x$"

.code
include tty.asm

main proc
	mov ax, ds
	mov es, ax

	mov ax, offset msg1
	push ax
	call puts

	mov cx, LEN
	mov di, offset a1
	cld

main__inp:
	call scn2x
	stosb
	loop main__inp

	mov si, offset a1
	mov cx, len
	lodsb
	dec cx
	mov bl, al
	mov bh, al
main__find:
	lodsb
	cmp al, bl
	ja main__higher
	mov bl, al
main__higher:
	cmp al, bh
	jb main__lower
	mov bh, al
main__lower:
	loop main__find

	; print output
	mov ax, offset msg2
	push ax
	call puts

	mov ah, bl
	push ax
	mov ax, 2
	push ax
	call prt_x

	mov ax, offset msg3
	push ax
	call puts

	mov ah, bh
	push ax
	mov ax, 2
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
