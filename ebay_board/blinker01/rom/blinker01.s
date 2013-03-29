
/*blinker01.s*/

.cpu cortex-m3
.thumb

.word   0x10008000  /* stack top address */
.word   _start      /* 1 Reset */
.word   hang        /* 2 NMI */
.word   hang        /* 3 HardFault */
.word   hang        /* 4 MemManage */
.word   hang        /* 5 BusFault */
.word   hang        /* 6 UsageFault */
.word   0xefff7e1d        /* 7 RESERVED */
.word   hang        /* 8 RESERVED */
.word   hang        /* 9 RESERVED*/
.word   hang        /* 10 RESERVED */
.word   hang        /* 11 SVCall */
.word   hang        /* 12 Debug Monitor */
.word   hang        /* 13 RESERVED */
.word   hang        /* 14 PendSV */
.word   hang        /* 15 SysTick */
.word   hang        /* 16 External Interrupt(0) */
.word   hang        /* 17 External Interrupt(1) */
.word   hang        /* 18 External Interrupt(2) */
.word   hang        /* 19 ...   */

.thumb_func
hang:   b .


.thumb_func
.globl _start
_start:
   ldr r0,=0x2009C040  /* FIO2DIR */
   ldrb r1,[r0]
   mov r2,#0x01
   orr r1,r2
   strb r1,[r0]

   ldr r0,=0x2009C050  /* GPIO2_MASK */
   mov r1,#0x00
   strb r1,[r0]

   ldr r0,=0x2009C058  /* FIO2SET */
   ldr r1,=0x2009C05C  /* FIO2CLR */
   ldr r2,=0x01

mainloop:
   strb r2,[r0]
   bl dowait
   strb r2,[r1]
   bl dowait
   b mainloop

.thumb_func
dowait:
   ldr r7,=0x40000
dowaitloop:
   sub r7,#1
   bne dowaitloop
   bx lr

.end
