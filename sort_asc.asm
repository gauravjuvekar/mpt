.model small
.stack 100h
.8086
.data
	a1 db 5 dup (?)
	LEN EQU 4
	msg1 db 10,13,"Enter 4 array bytes: $"
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
main__inp:
	call scn2x
	stosb
	loop main__inp

	mov ax, offset msg_eol
	push ax
	call puts

	mov di, offset a1
	mov cx, LEN

main__pass2:
	mov dx, cx
	mov si, di
	jmp main__lower
main__pass1:
	cmp al, [si]
	jbe main__higher
main__lower:
	mov bx, si
	mov al, [bx]
main__higher:
	inc si
	dec dx
	jnz  main__pass1

	xchg al, [di]
	mov [bx], al
	inc di
	dec cx
	jnz main__pass2

	mov si, offset a1
	mov cx, LEN
main__out:
	lodsb
	mov ah, al
	push ax
	mov ax, 2
	push ax
	call prt_x
	loop main__out

	ret
endp main
.startup
	mov ax, @data
	mov ds, ax

	call main
	mov ax, 4c00h
	int 21h
end
