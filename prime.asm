.model small
.stack 100h
.8086
.data
	msg1 db 10,13,"Enter the no : 0x$"
	msg2 db 10,13,"Number is prime$"
	msg3 db 10,13,"Number is not prime$"

.code
include tty.asm

main proc
	mov ax, offset msg1
	push ax
	call puts
	call scn4x
	mov si, ax

	cmp ax, 1
	jbe main__not_prime

	cmp ax, 3
	jbe main__prime

	; Check if even
	ror ax, 1
	jnc main__not_prime

	mov bl, 3

main__test:
	mov ax, si
	div bl
	cmp ah, 00h
	je main__not_prime
	add bl, 2
	mov al, bl
	mul bl
	cmp ax, si
	jbe main__test
	; prime
main__prime:
	mov ax, offset msg2
	jmp main__end

main__not_prime:
	mov ax, offset msg3
main__end:
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
