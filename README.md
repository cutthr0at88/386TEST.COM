## About This Project

**ALPHA LEGION 386TEST** is a small, AI-developed MS-DOS diagnostic and stress-testing utility designed to test the stability and functionality of vintage Intel and AMD 80386 processors.
The project started as a personal experiment after repairing a damaged CPU connection on a 386DX-40 motherboard. The damaged connection was repaired by carefully resoldering it under a microscope.
Although the computer appeared to work correctly, I wanted to verify that the processor could reliably execute its instructions without errors, particularly under prolonged stress.
Unable to find a suitable diagnostic program that provided the level of testing I wanted, I decided to develop one with the assistance of ChatGPT.

The program has been developed entirely with AI assistance, while testing and validation are performed on real vintage hardware.

### Test System

| Component | Specification |
|---|---|
| Motherboard | DataExpert OPTi-495SLC 3406 Rev. 1.2 |
| Processor | 80386DX-40, 40 MHz |
| Cache | 256 KB |
| RAM | 8 MB |
| Operating System | MS-DOS 6.2 |
| Diagnostic Software | ALPHA LEGION 386TEST |
| Development | AI-assisted (OpenAI ChatGPT) |

### Project Goals

- Verify correct execution of 80386 instructions.
- Detect arithmetic, logical and register-related errors.
- Stress-test processors through continuous instruction execution.
- Identify intermittent faults that may not appear during normal operation.
- Provide a lightweight diagnostic tool for vintage computer enthusiasts.
- Maintain compatibility with original 80386 hardware and MS-DOS.

### Development and Testing

Each version is tested on the original 386DX-40 system.
Earlier versions have successfully completed millions of diagnostic cycles without reporting errors.
The project is continuously evolving, with additional instruction tests, more demanding workloads and improved error detection being introduced in subsequent releases.

### Important Notes

This software is experimental and provided without warranty.
Although the program verifies the results of selected CPU instructions, passing all tests does not guarantee that a processor or motherboard is completely fault-free.
The software has been developed with AI assistance and is being evaluated on real vintage hardware. Bugs or incorrect test implementations may still exist.
Feedback, bug reports and test results from other 386 systems are welcome.

---

*The Emperor protects. The Machine Spirit endures.* ⚙️

Latest Release

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
