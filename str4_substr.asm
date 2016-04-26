.model small
.stack 100h
.8086
.data
	a1 db 100 dup (?)
	a2 db 20 dup (?)
	ldiff dw 1 dup (?)
	len_a2 dw 1 dup (?)
	msg1 db 10,13,"Enter string: $"
	msg2 db 10,13,"Enter substring: $"
	msg3 db 10,13,"Not found$"
	msg4 db 10,13,"Found at 0x$"


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
	mov ldiff, ax

	mov ax, offset msg2
	push ax
	call puts

	mov ax, offset a2
	push ax
	call gets
	mov len_a2, ax
	sub ldiff, ax

	mov di, offset a1

	jmp main__loop_start
main__loop:
	repnz scasb
	jnz main__not_found
	dec di
	mov dx, di
	mov cx, len_a2
	repz cmpsb
	jz main__found
	mov di, dx
	inc di
main__loop_start:
	mov si, offset a2
	mov al, [si]
	mov cx, ldiff
	inc cx
	sub cx, di
	add cx, offset a1
	jnz main__loop

main__not_found:
	mov ax, offset msg3
	push ax
	call puts
	ret

main__found:
	mov ax, offset msg4
	push ax
	call puts
	sub di, len_a2
	sub di, offset a1
	push di
	mov ax, 4
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
