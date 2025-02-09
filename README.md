# Optimized memset Implementation for RISC-V

This repository contains an optimized implementation of the `memset` function for RISC-V, written in assembly language. The implementation is designed to handle both aligned and misaligned memory accesses efficiently, with a focus on cases where the length is a multiple of 4 (which accounts for 90% of calls in the target application).

## Features
- **Efficient handling of aligned memory**: Uses 32-bit (`sw`) writes for lengths that are multiples of 4.
- **Handling of misaligned memory**: Writes bytes one at a time (`sb`) until the pointer is aligned, then switches to 32-bit writes.
- **Small code size**: The implementation is optimized for minimal static code size.
- **Robust testing**: Includes a test program to verify correctness in various scenarios.

## Repository Structure
├── memset.S # Assembly implementation of memset
├── test_memset.c # C program to test the memset function
├── Makefile # Makefile to build and run the tests
└── README.md # This file


## Building and Testing

### Prerequisites
- A RISC-V toolchain (e.g., `riscv64-unknown-elf-gcc`).
- GNU Make (for building using the provided Makefile).

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/memset.git
   cd memset


2. Build the test program:
   ```bash
    make


3. Run the tests:
   ```bash
    make run
