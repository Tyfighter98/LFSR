.data

.balign 4
seed:
	.word 0x5AA5FF00

.balign 4
tap:
	.word 0x51800000

.text

.balign 4
.global main
main:
	b lfsr32_1

lfsr32_1:
	eor r0, r0 // lfsr = 0
	eor r1, r1 // tap = 0
	eor r2, r2 // period = 0
	eor r3, r3 // lsb = 0
	ldr r0, addr_of_seed // load the address of seed data
	ldr r0, [r0] // load the data of seed
	ldr r1, addr_of_tap // load the address of tap data
	ldr r1, [r1] // load the data of tap
	mov r3, r0
	and r3, #1 // lsb = lsb & 1
	cmp r3, #1
	beq eq_1

lfsr32_2:
	add r2, #1
	bx lr
eq_1:
	eor r0, r1
	b lfsr32_2
addr_of_seed : .word seed
addr_of_tap : .word tap
