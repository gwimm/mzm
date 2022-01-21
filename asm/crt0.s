    .include "asm/constants.s"
    .include "asm/macros.s"

    arm_func_start _start
_start:
    mov r0, #PSR_IRQ_MODE
    msr cpsr_fc, r0
    ldr sp, sp_irq_ptr
    mov r0, #PSR_SYS_MODE
    msr cpsr_fc, r0
    ldr sp, sp_sys_ptr
    ldr r1, intr_vector_ptr
    add r0, pc, #0x20 @ intr_main
    str r0, [r1]
    ldr r1, main_loop_ptr
    mov lr, pc
    bx r1
    b _start

@ pool
sp_sys_ptr: .4byte sp_sys
sp_irq_ptr: .4byte sp_irq
intr_vector_ptr: .4byte intr_vector
main_loop_ptr: .4byte 0x0800023d
