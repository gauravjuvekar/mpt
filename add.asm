.model small
.stack 100h
.data
	msg1 db 10,13,"Enter the first no: 0x$"
	msg2 db 10,13,"Enter the second no: 0x$"
	msg3 db 10,13,"Result: 0x$"
	a1 db ?
	a2 db ?

.code
include tty.asm
main proc
	mov ax, OFFSET msg1
	push ax
	call puts

	call scn2x
	mov a1, al

	mov ax, OFFSET msg2
	push ax
	call puts

	call scn2x
	mov a2, al

	mov ax, OFFSET msg3
	push ax
	call puts

	mov ax, 0000h
	mov al, a1
	add al, a2

	push ax
	mov ax, 4
	push ax
	call prt_x

    mov ax, 4c00h
    int 21h
endp main

.startup
    mov ax, @data
    mov ds, ax

	jmp main
end

