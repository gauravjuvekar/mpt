.model small
.stack 100h
.8086
.data
	s1 db 100 dup (?)
	s2 db 100 dup (?)
	msg1 db 10,13,"Enter string 1: $"
	msg2 db 10,13,"Enter string 2: $"
	msg3_1 db 10,13, "String $"
	msg3_2 db " is lexicographically first$"


.code
include tty.asm

main proc
	mov ax, ds
	mov es, ax

	mov ax, offset msg1
	push ax
	call puts

	mov ax, offset s1
	push ax
	call gets
	mov cx, ax ;length

	mov ax, offset msg2
	push ax
	call puts

	mov ax, offset s2
	push ax
	call gets
	cmp ax, cx
	jb main__s2_shorter
	mov cx, ax
main__s2_shorter:

	mov si, offset s1
	mov di, offset s2
	cld
	mov dl, '1'
	repz cmpsb
	jb main__out
	mov dl, '2'
main__out:
	mov ax, offset msg3_1
	push ax
	call puts
	; print string number
	mov ah, 02h
	int 21h

	mov ax, offset msg3_2
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
