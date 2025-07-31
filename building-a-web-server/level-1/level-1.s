.global _start
.intel_syntax noprefix

_start:
	jmp _exit

_exit:
	mov rax, 60
	mov rdi, 0
	syscall
