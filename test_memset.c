#include <stdio.h>
#include <stdint.h>
#include <string.h>

// Declare the memset function written in assembly
extern void *memset(void *s, int c, size_t n);

int main() {
    uint8_t buffer[32];

    // Test 1: Set 16 bytes (multiple of 4)
    memset(buffer, 0xAA, 16);
    for (int i = 0; i < 16; i++) {
        if (buffer[i] != 0xAA) {
            printf("Test 1 failed at index %d\n", i);
            return 1;
        }
    }
    printf("Test 1 passed\n");

    // Test 2: Set 10 bytes (not a multiple of 4)
    memset(buffer, 0xBB, 10);
    for (int i = 0; i < 10; i++) {
        if (buffer[i] != 0xBB) {
            printf("Test 2 failed at index %d\n", i);
            return 1;
        }
    }
    printf("Test 2 passed\n");

    // Test 3: Set 0 bytes (edge case)
    memset(buffer, 0xCC, 0);
    printf("Test 3 passed\n");

    // Test 4: Misaligned pointer
    uint8_t *misaligned_ptr = (uint8_t *)((uintptr_t)buffer + 1);
    memset(misaligned_ptr, 0xDD, 8);
    for (int i = 0; i < 8; i++) {
        if (misaligned_ptr[i] != 0xDD) {
            printf("Test 4 failed at index %d\n", i);
            return 1;
        }
    }
    printf("Test 4 passed\n");

    printf("All tests passed!\n");
    return 0;
}
