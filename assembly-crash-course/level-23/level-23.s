.global _start
.intel_syntax noprefix

_start:
	# prepare the stack for the function. (prolog).
	mov rbp, rsp
	sub rsp, 0x100			# allocate memory for the list

	xor rax, rax
	xor rbx, rbx			# initialize the variable 'i' to 0.
	xor rcx, rcx			# current byte

	_loop:
		cmp rbx, rsi					# check if var 'i' is greater than or equal to 0
		jge _next						# if true then jump to the next loop, otherwise continue in the current loop.
		
		# do the operation inside the loop.
		mov cl, byte ptr[rdi+rbx]		# get the byte at index 'i'.
		
		mov rax, rbp			# move rbp into rax
		sub rax, rcx			# subtract the multipled value from rax which is rbp
		add byte ptr[rax], 1	# add one inside the [rax] cell
		
		# increment 'i'
		inc rbx
		jmp _loop

	_next:
		# prepare registers for the loop2.
		xor rax, rax			# reserved for addressing.
		xor rbx, rbx			# max_freq = 0
		xor rcx, rcx			# max_freq_byte = 0
		mov rdx, 1				# 'b'
		xor r8, r8

	_loop2:
		cmp rdx, 0xff			# check if var 'b' is greaterthan or equal to 0x100
		jg _done				# if 'yes' jump to done.

		# otherwise continue in the loop.
		mov rax, rbp			# move the value of rbp into rax for subtraction
		sub rax, rdx			# subtract the multipled rdx from rax ([rbp-rdx]) [rax = rax - rdx]

		cmp byte ptr[rax], bl		# check value at memory address [rbp-rdx*2] against rbx which is 'max_freq'
		jg _greater_than
		jmp _increment_b_rdx

	_greater_than:
		mov bl, [rax]			# max_freq = [stack_base - b * 2]
		mov rcx, rdx			# max_freq_byte = b

	_increment_b_rdx:
		inc rdx
		jmp _loop2

_done:
	mov rax, rcx
	mov rsp, rbp
	ret
