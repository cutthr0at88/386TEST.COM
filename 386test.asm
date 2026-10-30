/* ALPHA LEGION 386TEST v0.1 - GNU as Intel syntax, DOS COM */
.intel_syntax noprefix
.code16
.global _start
_start:
    push cs
    pop ds
    mov dx, offset banner
    call puts
main_loop:
    call test_cpu
    inc word ptr [passes]
    jnz no_wrap
    inc word ptr [passes_hi]
no_wrap:
    test word ptr [passes], 0x0fff
    jnz check_key
    mov dx, offset progress
    call puts
    mov ax, [passes_hi]
    call print_hex16
    mov ax, [passes]
    call print_hex16
    mov dx, offset newline
    call puts
check_key:
    mov ah, 0x0b
    int 0x21
    test al, al
    jz main_loop
    mov ah, 0x08
    int 0x21
    cmp al, 27
    jne main_loop
    mov dx, offset stopped
    call puts
    mov ax, 0x4c00
    int 0x21

/* Fail labels distinguish test group; all operands are deterministic. */
test_cpu:
    pushad
    pushf
    /* 32-bit ADD, SUB, ADC, SBB and flags */
    mov eax, 0x7fffffff
    add eax, 1
    jno fail_arith
    cmp eax, 0x80000000
    jne fail_arith
    sub eax, 1
    cmp eax, 0x7fffffff
    jne fail_arith
    mov eax, 0xffffffff
    add eax, 1
    jnc fail_arith
    adc eax, 0
    cmp eax, 1
    jne fail_arith
    stc
    sbb eax, 1
    cmp eax, 0xffffffff
    jne fail_arith
    /* Unsigned multiply, divide, signed multiply */
    mov eax, 0x12345678
    mov ebx, 16
    mul ebx
    cmp eax, 0x23456780
    jne fail_mul
    cmp edx, 1
    jne fail_mul
    div ebx
    cmp eax, 0x12345678
    jne fail_mul
    test edx, edx
    jne fail_mul
    mov eax, -12345
    imul eax, eax, 37
    cmp eax, -456765
    jne fail_mul
    /* Logic, shifts, rotates */
    mov eax, 0x55aa33cc
    xor eax, 0xffffffff
    cmp eax, 0xaa55cc33
    jne fail_logic
    and eax, 0x00ff00ff
    cmp eax, 0x00550033
    jne fail_logic
    or eax, 0x12000000
    cmp eax, 0x12550033
    jne fail_logic
    mov eax, 0x80000001
    rol eax, 1
    cmp eax, 3
    jne fail_logic
    shr eax, 1
    cmp eax, 1
    jne fail_logic
    mov eax, -8
    sar eax, 2
    cmp eax, -2
    jne fail_logic
    /* 386 bit instructions and bit scan */
    xor eax, eax
    bts eax, 31
    cmp eax, 0x80000000
    jne fail_bits
    bt eax, 31
    jnc fail_bits
    btr eax, 31
    jnc fail_bits
    test eax, eax
    jne fail_bits
    mov ebx, 0x1000
    bsf ecx, ebx
    cmp ecx, 12
    jne fail_bits
    bsr ecx, ebx
    cmp ecx, 12
    jne fail_bits
    /* Sign extension and 32-bit register transfers */
    mov al, 0x80
    movsx edx, al
    cmp edx, -128
    jne fail_regs
    movzx edx, al
    cmp edx, 128
    jne fail_regs
    mov eax, 0x13579bdf
    push eax
    xor eax, eax
    pop eax
    cmp eax, 0x13579bdf
    jne fail_regs
    popf
    popad
    ret
fail_arith:
    mov dx, offset err_arith
    jmp failed
fail_mul:
    mov dx, offset err_mul
    jmp failed
fail_logic:
    mov dx, offset err_logic
    jmp failed
fail_bits:
    mov dx, offset err_bits
    jmp failed
fail_regs:
    mov dx, offset err_regs
failed:
    /* A mismatch is fatal; do not return with corrupted registers. */
    push cs
    pop ds
    call puts
    mov ax, 0x4c01
    int 0x21
puts:
    mov ah, 0x09
    int 0x21
    ret
print_hex16:
    push ax
    push bx
    push cx
    push dx
    mov bx, ax
    mov cx, 4
hex_loop:
    rol bx, 4
    mov dl, bl
    and dl, 15
    cmp dl, 9
    jbe digit
    add dl, 7
digit:
    add dl, '0'
    mov ah, 2
    int 0x21
    loop hex_loop
    pop dx
    pop cx
    pop bx
    pop ax
    ret
banner: .ascii "\r\nALPHA LEGION 80386 CPU DIAGNOSTIC v0.1\r\n"
        .ascii "32-bit instruction verification / MS-DOS\r\n"
        .ascii "Press ESC to stop. PASS count in hexadecimal.\r\n$"
progress: .ascii "PASS cycles: $"
/* DOS strings must terminate with '$'. */
newline: .ascii "\r\n$"
stopped: .ascii "\r\nStopped by user.\r\n$"
err_arith: .ascii "\r\nFAIL: Arithmetic / flags\r\n$"
err_mul: .ascii "\r\nFAIL: Multiply / divide\r\n$"
err_logic: .ascii "\r\nFAIL: Logic / shifts / rotate\r\n$"
err_bits: .ascii "\r\nFAIL: Bit operations\r\n$"
err_regs: .ascii "\r\nFAIL: Register / stack\r\n$"
passes: .word 0
passes_hi: .word 0
