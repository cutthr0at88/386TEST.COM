ALPHA LEGION 80386 CPU DIAGNOSTIC v0.6 - MAXIMUM TORTURE
=======================================================

Files:
  386TST06.COM       DOS 6.2/6.22 real-mode program (80386 or later)
  386test-v06.asm    GNU assembler source code

Run:
  C:\>386TST06

All six groups run continuously. ESC stops the program.
Every 1024 passes, a hexadecimal pass counter is printed.
A PASS is a complete iteration of the six groups, not an instruction count.
Failures display the category and exit with DOS ERRORLEVEL 1.
Normal ESC exit returns ERRORLEVEL 0. No log files are written.

TEST GROUPS
  Arithmetic: 128 deterministic pseudorandom pairs per pass;
    32-bit ADD/SUB compared to separately calculated 16-bit
    low/high carry/borrow reference. Overflow/carry/zero flag
    vectors, known signed IDIV and unsigned MUL vectors.
  Bits: all 32 positions via BSF/BSR/BTR/BTS/BTC; rotate and SHLD.
  Registers: XCHG, 32-bit PUSH/POP and PUSHAD/POPAD.
  Memory: 256-byte 55h/AAh patterns, 128 unaligned 32-bit
    write/read comparisons in program-owned memory.
  Strings: REP MOVSB, REPE CMPSB, REP STOSB, REPE SCASB.
  Branches: repeated conditional branch loop and checksum.

BUILD ON LINUX (GNU binutils):
  as --32 -o 386test-v06.o 386test-v06.asm
  ld -m elf_i386 -Ttext 0x100 --oformat binary -o 386TST06.COM 386test-v06.o

VALIDATION PERFORMED
  - GNU as assembled source without errors.
  - GNU ld produced an 1826-byte flat binary linked at COM offset 0100h.
  - objdump -D -b binary -m i8086 -M intel inspected entry point,
    operand-size prefixes, calls and DOS interrupt instructions.
  - SHA256: 2fd6375d6d7b404c63f5393f6aae54ae457891e24561da41fabe38c42d27383b

NOT YET VALIDATED
  - No DOS emulator or physical 386 was available in the build
    environment. Execution and diagnostic accuracy are NOT verified.
  - First run should be short, under plain DOS, with a backup of
    important data. A defect or test bug can hang the system.

LIMITATIONS
  - This is not exhaustive instruction-set coverage, protected-mode
    verification, or a comprehensive cache/RAM test.
  - Small program-owned memory buffers do not test all physical RAM
    or address lines. No hardware temperature monitoring.
  - References use the same CPU, so common-mode faults can escape.
  - The bit/branch tests use fixed vectors; the arithmetic sequence
    is deterministic but not independently modelled off-machine.
  - DOS/BIOS services and interrupts may influence timing.
  - No selectable modes, elapsed timer, logging, or pause key yet.
  - CS, DS and ES are set to the program segment, as expected for COM.

Keep v0.5 as a known-working baseline and report the exact failure
message if the new version stops unexpectedly.
