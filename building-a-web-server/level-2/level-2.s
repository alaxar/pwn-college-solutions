.global _start
.intel_syntax noprefix

_start:
	jmp _socket
	jmp _exit

_socket:
	mov rdi, 2
	mov rsi, 1
	mov rdx, 0
	mov rax, 41
	syscall

	# check if socket is returned successfully.
	cmp rax, -1
	jne _exit
	mov rdi, -1
	mov rax, 60
	syscall
	

_exit:
	mov rax, 60
	mov rdi, 0
	syscall	
