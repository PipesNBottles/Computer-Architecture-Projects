.data
	int_specifier: .asciz "%d %d"
	int_specifier2: .asciz "%d"
	prompt: .asciz "Enter Two Integers: "
	int_input_buffer: .space 8
	int_2_input_buffer: .space 8
	newline: .asciz "\n"
	prompt2: .asciz "2 is bigger than 1\n"
	prompt3: .asciz "done\n"
	prompt4: .asciz "done 4\n"
.text

.global main

main:

	//Load the input prompt and print it out
	ldr x0, =prompt
	bl printf

	//Take in the input and save it in the buffer
	ldr x0, =int_specifier
	ldr x1, =int_input_buffer
	ldr x2, =int_2_input_buffer
	bl scanf

	ldr x21, =int_input_buffer
	ldr x22, =int_2_input_buffer

	//22 -> n; 21 -> m
	ldr w22, [x22]
        ldr w21, [x21]

	CMP w22, #0
	b.lt neg1

	continue:
	CMP w21, #0
        b.lt neg2

	continue2:
	CMP w22, w21
	b.gt greater

	bl gcd
	b end

gcd:
	sub sp, sp, #32
	str x30, [sp, #8]
	str x20, [sp, #16]
	str x21, [sp, #24]
	CBZ w22, found

	b mod

	

greater:

	mov x19, x21
	mov x21, x22
	mov x22, x19
	bl gcd

end:
	# Call to exit and return back to our lives
	ldr x0, =int_specifier2
	bl printf
	ldr x0, =newline
	bl printf
	mov x0, #0
	mov x8,#93
	svc #0

neg1:
        neg w22, w22
	b continue


neg2:
        neg w21, w21
	b continue2

mod:
	udiv w23, w21, w22
	mul w24, w23, w22
	sub w25, w21, w24
	b swap

swap:
	mov w21, w22
        mov w22, w25
	bl gcd
	ldr x30, [sp, #8]
	add sp, sp, #32
	br x30

found:
	mov x1, x21
	add sp, sp, #32
	br x30
