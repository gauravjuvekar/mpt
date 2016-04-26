.model small
.stack 100h
.8086
.data
	a1 db 4 dup (?)
	a2 db 4 dup (?)
	LEN EQU 4

	msg1 db 10,13,"Enter 4 array bytes: $"
	msg2 db 10,13,"Contents exchanged",10,13,"$"
	msg_eol db 10,13,"$"

.code
include tty.asm

main proc
	mov ax, ds
	mov es, ax

	cld

	mov ax, offset msg1
	push ax
	call puts
	mov cx, LEN
	mov di, offset a1
main__inp1:
	call scn2x
	stosb
	loop main__inp1

	mov ax, offset msg1
	push ax
	call puts
	mov cx, LEN
	mov di, offset a2
main__inp2:
	call scn2x
	stosb
	loop main__inp2

	mov si, offset a1
	mov di, offset a2
	mov cx, LEN

main__xchg:
	mov ah, [di]
	mov al, [si]
	mov [di], al
	mov [si], ah
	inc si
	inc di
	loop main__xchg

	mov ax, offset msg2
	push ax
	call puts

	mov bx, 0002h
	mov si, offset a1
	mov cx, LEN
main__prt1:
	lodsb
	mov ah, al
	push ax
	push bx
	call prt_x
	loop main__prt1

	mov ax, offset msg_eol
	push ax
	call puts

	mov si, offset a2
	mov cx, LEN
main__prt2:
	lodsb
	mov ah, al
	push ax
	push bx
	call prt_x
	loop main__prt2

	ret
endp main
.startup
	mov ax, @data
	mov ds, ax

	call main
	mov ax, 4c00h
	int 21h
end
