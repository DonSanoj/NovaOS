[org 0x7c00]
[bits 16]

KERNEL_LOAD_ADDR equ 0x1000
KERNEL_SECTORS   equ 16

start:
	cli
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7c00
	sti

	mov [boot_drive], dl

	mov si, dap
	mov dl, [boot_drive]
	mov ah, 0x42
	int 0x13
	jc disk_error

	cli
	lgdt [gdt_desc]
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp CODE_SEG:protected_mode

disk_error:
	mov ah, 0x0e
	mov al, 'E'
	int 0x10
	jmp $

[bits 32]
protected_mode:
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov fs, ax
	mov gs, ax
	mov esp, 0x90000
	jmp KERNEL_LOAD_ADDR

dap:
	db 0x10
	db 0
	dw KERNEL_SECTORS
	dw KERNEL_LOAD_ADDR
	dw 0
	dq 1

boot_drive db 0

gdt_start:
	dq 0
gdt_code:
	dw 0xffff
	dw 0
	db 0
	db 10011010b
	db 11001111b
	db 0
gdt_data:
	dw 0xffff
	dw 0
	db 0
	db 10010010b
	db 11001111b
	db 0
gdt_end:

gdt_desc:
	dw gdt_end - gdt_start - 1
	dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

times 510-($-$$) db 0
dw 0xaa55