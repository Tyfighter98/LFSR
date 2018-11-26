/* -- hello01.s */
.data
 
.balign 4
greeting: .asciz "Hello world: %d\n"
msg: .asciz "Second msg!!!: %d\n"

.text
 
.global main
main:
    ldr r0, =greeting   /* r0 ← &address_of_greeting */
    mov r1, #20                              /* First parameter of puts */
 
    bl printf                       /* Call to puts */

    ldr r0, =msg
    mov r1, #21

    bl printf
                                  /* lr ← address of next instruction */
    bx lr                         /* return from main */
 
/* External */
.global printf
