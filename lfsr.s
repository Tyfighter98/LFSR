.data

.balign 4
seed:
	.word 0x5AA5FF00

.balign 4
tap:
	.word 0xA3000000

.balign 4
result: .asciz "The 32nd value is: %8x\n"

.text

.balign 4
.global main
main:
	b lfsr32

lfsr32:
	eor r0, r0 		// lfsr = 0
	eor r1, r1 		// tap = 0
	eor r2, r2 		// period = 0
	eor r3, r3 		// lsb = 0
	eor r4, r4 		// seed = 0
	ldr r0, addr_of_seed 	// load the address of seed data
	ldr r0, [r0] 		// load the data of seed
	ldr r1, addr_of_tap 	// load the address of tap data
	ldr r1, [r1] 		// load the data of tap
	mov r3, r0 		// lsb = lfsr
	mov r4, r0 		// seed = lfsr
	and r3, #1 		// lsb = lsb & 1
	lsr r0, r0, #1 		// lfsr >>= 1
	cmp r3, #1 		// if(lsb == 1)
	beq eq_1 		// branch if true

while_1:
	add r2, #1 		// period++
	cmp r0, r4 		// while (lfsr != seed)
	beq exit 		// exit if lfsr == seed
	cmp r2, #32 		// if (period < 32)
	bge exit 		// exit if period > 32 
	mov r3, r0 		// lsb = lfsr
	and r3, #1 		// lsb = lsb & 1
	lsr r0, r0, #1 		// lfsr >>= 1
	cmp r3, #1 		// if(lsb == 1)
	beq eq_1 		// branch if true
	b while_1 		// loop

eq_1:
	eor r0, r1		// lfsr ^= tap
	b while_1		// loop

exit:
	mov r5, r0		// r5 = lfsr
	ldr r0, =result		// load print statement
	mov r1, r5		// r1 = r5 (used as argument for print statment)

	bl printf		// Branch and link to printf

	bx lr			// Exit application and return to memory location

addr_of_seed : .word seed
addr_of_tap : .word tap
.global printf
