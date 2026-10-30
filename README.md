Created With AI

ALPHA LEGION 80386 CPU DIAGNOSTIC v0.1
====================================

Files:
  386TEST.COM   DOS executable (80386 or newer)
  386test.asm   GNU assembler source (Intel syntax)

RUNNING
  Boot MS-DOS 6.2/6.22 and run: 386TEST
  Press ESC to stop. Program prints completed passes in hexadecimal
  every 4096 cycles. On a detected mismatch it prints the failing
  test group and exits with errorlevel 1.

BUILD ON LINUX (GNU binutils)
  as --32 -o 386test.o 386test.asm
  ld -m elf_i386 -Ttext 0x100 --oformat binary -o 386TEST.COM 386test.o

SCOPE
  Initial deterministic tests: 32-bit add/sub/adc/sbb and overflow/carry,
  32-bit unsigned multiply/divide, signed multiply, logical operations,
  shifts/rotates, BT/BTS/BTR/BSF/BSR, MOVSX/MOVZX, 32-bit stack roundtrip.
  This is NOT comprehensive instruction coverage or a complete CPU health
  certification. It does not test protected mode, cache, or all memory.

WARNING
  This executable has been assembled and inspected, but has NOT been run
  on a DOS emulator or physical 386 in this environment. Try it on a
  noncritical DOS installation. Hardware faults may cause a hang or crash.
  No disk writes are performed by the program.
