.model small
.stack 100h
.8086
.data
	s1 db "hello$", 20 dup (?)
	s2 db "world$"

.code
include tty.asm

main proc
	mov ax, ds
	mov es, ax

	mov di, offset s1
	mov si, offset s2
	cld

main__scn_1:
	mov al, '$'
	scasb
	jne main__scn_1
	dec di

main__concat:
	lodsb
	cmp al, '$'
	je main__end
	stosb
	jmp main__concat
main__end:
	stosb

	mov ax, offset s1
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
