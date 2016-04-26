.model small
.stack 100h
.8086
.data
	a1 db 100 dup (?)
	msg1 db 10,13,"Enter string: $"
	msg_nchar db 10,13,"Not alpha: $"
	msg_vowel db 10,13,"Vowel    : $"
	msg_conso db 10,13,"Consonent: $"
	msg_eol db 10,13,"$"
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

	mov cx, ax; strlen(a1)

	mov si, offset a1

main__loop:
	lodsb
	cmp al, 'A'
	jb main__notchar
	cmp al, 'Z'
	jb main__char
	cmp al, 'a'
	jb main__notchar
	cmp al, 'z'
	jb main__char
	jmp main__notchar
main__char:
	cmp al, 'A'
	jz main__vowel
	cmp al, 'E'
	jz main__vowel
	cmp al, 'I'
	jz main__vowel
	cmp al, 'O'
	jz main__vowel
	cmp al, 'U'
	jz main__vowel
	cmp al, 'a'
	jz main__vowel
	cmp al, 'e'
	jz main__vowel
	cmp al, 'i'
	jz main__vowel
	cmp al, 'o'
	jz main__vowel
	cmp al, 'u'
	jz main__vowel
main__consonent:
	mov bx, offset msg_conso
	jmp main__prtchar
main__vowel:
	mov bx, offset msg_vowel
	jmp main__prtchar
main__notchar:
	mov bx, offset msg_nchar
main__prtchar:
	mov dl, al
	push bx
	call puts

	mov ah, 02h
	int 21h
	loop main__loop

	mov bx, offset msg_eol
	push bx
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
