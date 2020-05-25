.data
outformat:     .asciz "%s" 
outformat_2: .asciz "%c" 
flush:          .asciz "\n"      
stringread:     .asciz "%[^\n]"  
strbuffer: .space 256       
number_specifier: .asciz "%d"
char_specifier: .asciz "%c"
input_buffer: .space 1
input_string: .asciz "input a string: "
letter_x: .asciz "x"

.text
.global main


main:
	    ldr x0, =outformat
            ldr x1, =input_string
            bl printf

            ldr x0, =stringread
            ldr x1, =strbuffer
            bl scanf

	    ldr x0, =strbuffer
	    bl for_loop
	    mov x1, x0
    after_loop:

	    //Flush the stdout buffer
            ldr x0, =flush
            bl printf

            //Exit the program
            b exit

for_loop:
	    mov x1, #0
	    mov x20, x0
    loop:
	    ldrb w21, [x20, x1]
	    mov x19, x1
	    cbz w21, loop_exit

	    //check if A
	    subs x22, x21, #65
	    b.eq print_not_1
	   
	    //check if a
            subs x22, x21, #97
            b.eq print_not_1

	    //check if E
            subs x22, x21, #69
            b.eq print_not_1

	    //check if e
            subs x22, x21, #101
            b.eq print_not_1
 
	    //check if O
	    subs x22, x21, #79
            b.eq print_not_1

	    //check if o
	    subs x22, x21, #111
            b.eq print_not_1

	    //check if U
	    subs x22, x21, #85
            b.eq print_not_1

	    //check if u
	    subs x22, x21, #117
            b.eq print_not_1

	    //check if I
	    subs x22, x21, #73
            b.eq print_not_1

	    //check if i
	    subs x22, x21, #105
            b.eq print_not_1

	   //print character in string 
	    b print_1

    increment:
	    mov x1, x19
	    add x1, x1, 1
	    b loop

    loop_exit:
	    b after_loop


exit:       mov x0, #0
            mov x8, #93
            svc #0

print_not_1:
       	    ldr x0, =letter_x
    	    bl printf
	    b increment

print_1:
	    ldr x0, =char_specifier
	    mov x1, x21
	    bl printf
	    b increment

