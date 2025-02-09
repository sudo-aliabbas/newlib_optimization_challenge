CC = riscv64-unknown-elf-gcc
CFLAGS = -Wall -Wextra -O2

all: test_memset

test_memset: test_memset.c memset.S
    $(CC) $(CFLAGS) -o test_memset test_memset.c memset.S

run: test_memset
    ./test_memset

clean:
    rm -f test_memset
