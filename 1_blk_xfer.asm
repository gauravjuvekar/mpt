.model small
.stack 100h
.8086
.data
	a1 db 4 dup (?)
	a2 db 4 dup (?)
	LEN EQU 4

	msg1 db 10,13,"Enter 4 array bytes: $"
	msg2 db 10,13,"Contents copied",10,13,"$"

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

	mov di, offset a2
	mov si, offset a1
	mov cx, LEN
	rep movsb

	mov ax, offset msg2
	push ax
	call puts

	mov si, offset a2
	mov cx, LEN

main__res_prt:
	lodsb
	mov ah, al
	push ax
	mov bx, 0002h
	push bx
	call prt_x
	loop main__res_prt

	ret
endp main
.startup
	mov ax, @data
	mov ds, ax

	call main
	mov ax, 4c00h
	int 21h
end
