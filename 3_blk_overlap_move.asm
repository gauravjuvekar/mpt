.model small
.stack 100h
.8086
.data
	a1 db 10 dup (0)
	LEN EQU 4
	OFF EQU 3

	msg1 db 10,13,"Enter 4 array bytes: $"
	msg2 db 10,13,"Copy to [0:6]: $"
	eol db 10,13,"$"

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
	mov si, di
	add di, OFF
	cld
main__inp:
	call scn2x
	stosb
	loop main__inp

	mov si, offset a1
	mov cx, 10
	mov ax, offset eol
	push ax
	call puts
main__loop1:
	lodsb
	mov ah, al
	push ax
	mov ax, 2
	push ax
	call prt_x
	loop main__loop1

	mov ax, offset msg2
	push ax
	call puts

	call scn4x
	mov di, ax
	add di, offset a1
	mov si, offset a1
	add si, OFF

	mov cx, LEN
	cld
	cmp si, di
	ja main__below
	std
	add si, LEN
	dec si
	add di, LEN
	dec di
main__below:
	lodsb
	stosb
	loop main__below

	mov si, offset a1
	mov cx, 10
	mov ax, offset eol
	push ax
	call puts
	cld
main__loop2:
	lodsb
	mov ah, al
	push ax
	mov ax, 2
	push ax
	call prt_x
	loop main__loop2

	ret
endp main
.startup
	mov ax, @data
	mov ds, ax

	call main
	mov ax, 4c00h
	int 21h
end
