.model small
.stack 100h
.8086
.data
	msg1 db 10,13,"Enter a: 0x$"
	msg2 db 10,13,"Enter b: 0x$"
	msg3 db 10,13,"Enter c: 0x$"
	msg4 db 10,13,"Enter d: 0x$"
	eol db 10,13,"$"
	msg_res db 10,13,"(a * b) + (c * d) = 0x$"

.code
include tty.asm

main proc
	mov ax, offset msg1
	push ax
	call puts
	call scn2x
	mov bx, 0
	mov bl, al

	mov ax, offset msg2
	push ax
	call puts
	call scn2x
	mov ah, 0
	mul bl
	mov dx, ax

	mov ax, offset msg3
	push ax
	call puts
	call scn2x
	mov cx, 0
	mov cl, al

	mov ax, offset msg4
	push ax
	call puts
	call scn2x
	mov ah, 0
	mul cl
	mov cl, '0'
	add ax, dx
	jnc main__nc
	mov cl, '1'
main__nc:
	push ax
	mov ax, 4
	push ax
	push cx

	mov ax, offset msg_res
	push ax
	call puts
	call putch
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
