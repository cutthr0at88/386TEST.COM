/* ALPHA LEGION 386TEST v0.6 - GNU as Intel syntax, 80386 real mode */
.intel_syntax noprefix
.code16
.global _start
_start:
    push cs
    pop ds
    push cs
    pop es
    cld
    mov dx, offset banner
    call puts
main_loop:
    call test_arithmetic
    call test_bitcrusher
    call test_registers
    call test_memory
    call test_strings
    call test_branches
    inc word ptr [passes]
    jnz no_carry
    inc word ptr [passes+2]
no_carry:
    test word ptr [passes], 0x03ff
    jnz poll
    mov dx, offset progress
    call puts
    mov eax, [passes]
    call hex32
    mov dx, offset crlf
    call puts
poll:
    mov ah, 0x0b
    int 0x21
    or al, al
    jz main_loop
    mov ah, 0x08
    int 0x21
    cmp al, 27
    jne main_loop
    mov dx, offset stopped
    call puts
    mov ax, 0x4c00
    int 0x21

/* 128 operand pairs per pass. 32-bit ADD and SUB independently
   checked against low/high 16-bit arithmetic with carry/borrow. */
test_arithmetic:
    pushad
    mov word ptr [iterations], 128
arith_loop:
    call random32
    mov [operand_a], eax
    call random32
    mov [operand_b], eax
    mov eax, [operand_a]
    add eax, [operand_b]
    mov [actual], eax
    mov ax, [operand_a]
    add ax, [operand_b]
    mov [expected], ax
    mov ax, [operand_a+2]
    adc ax, [operand_b+2]
    mov [expected+2], ax
    mov eax, [actual]
    cmp eax, [expected]
    jne fail_alu
    mov eax, [operand_a]
    sub eax, [operand_b]
    mov [actual], eax
    mov ax, [operand_a]
    sub ax, [operand_b]
    mov [expected], ax
    mov ax, [operand_a+2]
    sbb ax, [operand_b+2]
    mov [expected+2], ax
    mov eax, [actual]
    cmp eax, [expected]
    jne fail_alu
    dec word ptr [iterations]
    jnz arith_loop
    /* Known signed/unsigned division, multiply, and flags boundaries */
    mov eax, 0x7fffffff
    add eax, 1
    pushf
    pop bx
    test bx, 0x0800
    jz fail_flags
    test bx, 1
    jnz fail_flags
    cmp eax, 0x80000000
    jne fail_flags
    mov eax, 0xffffffff
    add eax, 1
    pushf
    pop bx
    test bx, 1
    jz fail_flags
    test bx, 0x40
    jz fail_flags
    mov eax, -123456
    cdq
    mov ebx, 37
    idiv ebx
    cmp eax, -3336
    jne fail_muldiv
    cmp edx, -24
    jne fail_muldiv
    mov eax, 0x12345678
    mov ebx, 16
    mul ebx
    cmp edx, 1
    jne fail_muldiv
    cmp eax, 0x23456780
    jne fail_muldiv
    popad
    ret

test_bitcrusher:
    pushad
    xor ecx, ecx
bits_loop:
    mov eax, 1
    shl eax, cl
    mov ebx, eax
    bsf edx, eax
    cmp edx, ecx
    jne fail_bits
    bsr edx, eax
    cmp edx, ecx
    jne fail_bits
    btr eax, ecx
    test eax, eax
    jne fail_bits
    bts eax, ecx
    cmp eax, ebx
    jne fail_bits
    btc eax, ecx
    test eax, eax
    jne fail_bits
    inc ecx
    cmp ecx, 32
    jb bits_loop
    mov eax, 0x80000001
    rol eax, 1
    cmp eax, 3
    jne fail_bits
    ror eax, 1
    cmp eax, 0x80000001
    jne fail_bits
    mov eax, 0x12345678
    mov edx, 0xabcdef01
    shld eax, edx, 4
    cmp eax, 0x2345678a
    jne fail_bits
    popad
    ret

test_registers:
    pushad
    mov eax, 0x11223344
    mov ebx, 0x55667788
    xchg eax, ebx
    cmp eax, 0x55667788
    jne fail_regs
    cmp ebx, 0x11223344
    jne fail_regs
    push eax
    push ebx
    xor eax, eax
    xor ebx, ebx
    pop ebx
    pop eax
    cmp eax, 0x55667788
    jne fail_regs
    cmp ebx, 0x11223344
    jne fail_regs
    popad
    ret

test_memory:
    pushad
    mov di, offset mem_buffer
    mov cx, 256
    mov al, 0x55
    rep stosb
    mov si, offset mem_buffer
    mov cx, 256
check55:
    cmp byte ptr [si], 0x55
    jne fail_memory
    inc si
    loop check55
    mov di, offset mem_buffer
    mov cx, 256
    mov al, 0xaa
    rep stosb
    mov si, offset mem_buffer
    mov cx, 256
checkaa:
    cmp byte ptr [si], 0xaa
    jne fail_memory
    inc si
    loop checkaa
    mov si, offset mem_buffer
    mov cx, 128
unaligned_loop:
    call random32
    mov dword ptr [si+1], eax
    cmp dword ptr [si+1], eax
    jne fail_memory
    inc si
    loop unaligned_loop
    popad
    ret

test_strings:
    pushad
    cld
    mov si, offset string_src
    mov di, offset string_dst
    mov cx, 32
    rep movsb
    mov si, offset string_src
    mov di, offset string_dst
    mov cx, 32
    repe cmpsb
    jne fail_strings
    cmp cx, 0
    jne fail_strings
    mov di, offset string_dst
    mov cx, 32
    mov al, 0x5a
    rep stosb
    mov di, offset string_dst
    mov cx, 32
    repe scasb
    jne fail_strings
    cmp cx, 0
    jne fail_strings
    popad
    ret

test_branches:
    pushad
    mov ecx, 100
    xor eax, eax
branch_loop:
    add eax, ecx
    dec ecx
    jnz branch_loop
    cmp eax, 5050
    jne fail_branch
    popad
    ret

/* Xorshift32 PRNG: deterministic, nonzero seed. */
random32:
    mov eax, [seed]
    mov edx, eax
    shl edx, 13
    xor eax, edx
    mov edx, eax
    shr edx, 17
    xor eax, edx
    mov edx, eax
    shl edx, 5
    xor eax, edx
    mov [seed], eax
    ret

fail_alu:
    mov dx, offset err_alu
    call fail_header
    mov dx, offset label_a
    call puts
    mov eax, [operand_a]
    call hex32
    mov dx, offset label_b
    call puts
    mov eax, [operand_b]
    call hex32
    mov dx, offset label_expected
    call puts
    mov eax, [expected]
    call hex32
    mov dx, offset label_actual
    call puts
    mov eax, [actual]
    call hex32
    jmp fail_exit
fail_flags:
    mov dx, offset err_flags
    jmp fail_simple
fail_muldiv:
    mov dx, offset err_muldiv
    jmp fail_simple
fail_bits:
    mov dx, offset err_bits
    jmp fail_simple
fail_regs:
    mov dx, offset err_regs
    jmp fail_simple
fail_memory:
    mov dx, offset err_memory
    jmp fail_simple
fail_strings:
    mov dx, offset err_strings
    jmp fail_simple
fail_branch:
    mov dx, offset err_branch
fail_simple:
    call fail_header
fail_exit:
    mov dx, offset crlf
    call puts
    mov ax, 0x4c01
    int 0x21
fail_header:
    push cs
    pop ds
    push dx
    mov dx, offset failtext
    call puts
    pop dx
    call puts
    mov dx, offset label_pass
    call puts
    mov eax, [passes]
    call hex32
    ret

puts:
    push ax
    mov ah, 9
    int 0x21
    pop ax
    ret
hex32:
    pushad
    mov ebx, eax
    mov cx, 8
hex_loop:
    rol ebx, 4
    mov dl, bl
    and dl, 15
    cmp dl, 9
    jbe hex_digit
    add dl, 7
hex_digit:
    add dl, '0'
    mov ah, 2
    int 0x21
    loop hex_loop
    popad
    ret

banner: .ascii "\r\nALPHA LEGION 80386 DIAGNOSTIC v0.6\r\n"
        .ascii "MAXIMUM TORTURE - continuous - ESC to stop\r\n"
        .ascii "32-bit CPU / bit / register / memory / string / branch tests\r\n"
        .ascii "PASS count in hexadecimal (every 1024 loops)\r\n$"
progress: .ascii "PASS cycles: $"
crlf: .ascii "\r\n$"
stopped: .ascii "Stopped by user.\r\n$"
failtext: .ascii "\r\n*** DIAGNOSTIC FAILURE *** $"
label_pass: .ascii " Pass=$"
label_a: .ascii " A=$"
label_b: .ascii " B=$"
label_expected: .ascii " Expected=$"
label_actual: .ascii " Actual=$"
err_alu: .ascii "32-bit ADD/SUB vs 16-bit reference$"
err_flags: .ascii "EFLAGS overflow/carry/zero$"
err_muldiv: .ascii "MUL/IDIV known vectors$"
err_bits: .ascii "bit operations / SHLD / rotate$"
err_regs: .ascii "register exchange / stack$"
err_memory: .ascii "memory patterns / unaligned stores$"
err_strings: .ascii "string operations$"
err_branch: .ascii "conditional branch loop$"
.p2align 2
passes: .long 0
seed: .long 0x38606001
operand_a: .long 0
operand_b: .long 0
expected: .long 0
actual: .long 0
iterations: .word 0
string_src: .fill 32,1,0x5a
string_dst: .space 32,0
mem_buffer: .space 260,0
