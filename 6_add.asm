.model small
.stack 100h
.8086
.data
	msg1 db 10,13,"Enter the no 1: 0x$"
	msg2 db 10,13,"Enter the no 2: 0x$"
	eol db 10,13,"$"
	msg_hex db "0x$"
	msg_add db " + $"
	msg_equ db " = $"

.code
include tty.asm

main proc
	mov ax, offset msg1
	push ax
	call puts
	call scn4x
	mov si, ax
	call scn4x
	mov di, ax

	mov ax, offset msg2
	push ax
	call puts
	call scn4x
	mov cx, ax
	call scn4x
	mov dx, ax

	; add 8 lower
	mov ax, offset eol
	push ax
	call puts

	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, di
	mov ah, al
	push ax
	mov ax, 2
	push ax
	call prt_x

	mov ax, offset msg_add
	push ax
	call puts
	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, dx
	mov ah, al
	push ax
	mov ax, 2
	push ax
	call prt_x

	mov ax, dx
	mov bx, di
	add al, bl
	mov ah, al
	push ax
	mov ax, 2
	push ax

	mov ax, offset msg_hex
	push ax
	mov ax, offset msg_equ
	push ax
	call puts
	call puts
	call prt_x

	; add 16 lower
	mov ax, offset eol
	push ax
	call puts

	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, di
	push ax
	mov ax, 4
	push ax
	call prt_x

	mov ax, offset msg_add
	push ax
	call puts
	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, dx
	push ax
	mov ax, 4
	push ax
	call prt_x

	mov ax, dx
	add ax, di
	push ax
	mov ax, 4
	push ax

	mov ax, offset msg_hex
	push ax
	mov ax, offset msg_equ
	push ax
	call puts
	call puts
	call prt_x

	; add 32 lower
	mov ax, offset eol
	push ax
	call puts

	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, di
	push ax
	mov ax, 4
	push ax
	mov ax, si
	push ax
	mov ax, 4
	push ax
	call prt_x
	call prt_x

	mov ax, offset msg_add
	push ax
	call puts
	mov ax, offset msg_hex
	push ax
	call puts

	mov ax, dx
	push ax
	mov ax, 4
	push ax
	mov ax, cx
	push ax
	mov ax, 4
	push ax
	call prt_x
	call prt_x

	mov ax, dx
	add ax, di
	push ax
	mov ax, si
	adc ax, cx
	mov bx, 4
	push bx
	push ax
	push bx

	mov ax, offset msg_hex
	push ax
	mov ax, offset msg_equ
	push ax
	call puts
	call puts
	call prt_x
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
