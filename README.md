ALPHA LEGION 80386 CPU DIAGNOSTIC v0.2 (experimental)
====================================================
Run on MS-DOS 6.2/6.22 with an Intel/AMD 80386 or newer:
  386TST02
ESC exits. Completed passes print in hexadecimal every 4096 passes.
On the first detected mismatch, a test-group FAIL message appears and
DOS receives ERRORLEVEL 1. No disk files are written.

NEW IN v0.2
- 256 pseudorandom 32-bit values per pass (persistent xorshift32 state)
- ADD/SUB, XOR, NOT, ROL/ROR round-trip verification
- Unsigned DIV/MUL quotient-and-remainder round-trip verification
- Extra flag checks (AF, OF, SF, ZF, CF)
- Unaligned 32-bit and byte/word memory access checks
- All v0.1 fixed-value tests retained

NOTE: Round-trip tests are not independent mathematical oracles: two
faulty operations could theoretically cancel. This does not test every
80386 instruction, every CPU flag case, or protected mode. A PASS is
not a guarantee of a fault-free CPU. This binary has been tested on physical hardware.
DataExpert OPTI-495SLC-3 with 386DX40Mhz CPU

Build on Linux with GNU binutils:
  as --32 -o 386test-v02.o 386test-v02.asm
  ld -m elf_i386 -Ttext 0x100 --oformat binary -o 386TST02.COM 386test-v02.o

CAUTION: Back up important data before testing suspect hardware.
