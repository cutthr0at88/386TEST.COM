# ALPHA LEGION 386TEST v0.6 — Maximum Torture Edition

**Release:** v0.6  
**Platform:** MS-DOS 6.2 / 6.22  
**CPU Requirements:** Intel 80386DX/SX or compatible AMD Am386  
**Test Mode:** Maximum Torture — Continuous

## What's New in v0.6

Version 0.6 introduces a more demanding CPU diagnostic and stress-testing engine designed to push vintage 80386 processors beyond basic arithmetic and instruction tests.

This release combines six diagnostic test groups into a continuous workload, exercising CPU registers, arithmetic operations, bit manipulation, memory addressing and instruction execution.

### New Features

- **Arithmetic Hell:** Executes 128 pseudorandom 32-bit operand pairs per pass, verifying ADD and SUB results using independent 16-bit calculations.
- **Bit Crusher:** Exercises all 32 bit positions using bit manipulation, rotation, bit scanning and double-shift instructions.
- **Register Warfare:** Tests register exchanges, stack operations and 32-bit register preservation.
- **Memory Chaos:** Performs 256-byte memory pattern checks and 128 unaligned 32-bit memory accesses.
- **Instruction Storm:** Exercises string operations and conditional branching.
- **Flags & Division:** Verifies selected arithmetic flags, signed division, multiplication and overflow conditions.

### Improved Diagnostics

- Continuous testing until manually stopped.
- Hexadecimal pass counter updated every 1,024 cycles.
- Immediate termination when a test detects an incorrect result.
- Failure reporting by diagnostic category.
- Detailed operand, expected-result and actual-result reporting for arithmetic failures.
- No additional drivers, runtime libraries or protected-mode extensions required.

### Compatibility

- Intel 80386DX / 80386SX
- AMD Am386DX / Am386SX
- Later x86 processors supporting the 80386 instruction set
- MS-DOS 6.2 / 6.22 and compatible real-mode DOS environments

### Usage

Copy `386TST06.COM` to your DOS machine and execute:

```dos
C:\>386TST06
```

The diagnostic runs continuously. Press **ESC** to exit.

### Testing and Validation

The executable has been assembled and subjected to build-level checks, including machine-code inspection and executable structure verification.

**Real-hardware validation is ongoing.** Passing the diagnostic does not guarantee a completely fault-free processor or motherboard.

### Planned Improvements

- Expanded 80386 instruction coverage.
- More comprehensive CPU flag verification.
- Detailed error logging.
- Selectable CPU, memory and mixed stress modes.
- Protected-mode segmentation and paging diagnostics.
- Improved live diagnostic interface.

---

**ALPHA LEGION 386TEST** is an experimental diagnostic and stress-testing utility for vintage x86 hardware.

*The Emperor protects. The Machine Spirit endures.* ⚙️
