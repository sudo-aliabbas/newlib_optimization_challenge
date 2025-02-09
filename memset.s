memset:
    mv t1, a0              # t1 = destination pointer
    beqz a2, done          # If length (a2) is zero, return

    # Handle misaligned pointer (write bytes one at a time until aligned)
    andi t2, t1, 3         # t2 = t1 % 4 (check alignment)
    beqz t2, aligned       # If already aligned, skip to the word loop

misaligned_loop:
    sb a1, 0(t1)           # Write byte
    addi t1, t1, 1         # Increment pointer
    addi a2, a2, -1        # Decrement length
    andi t2, t1, 3         # Check alignment again
    bnez t2, misaligned_loop # If not aligned, repeat

    # Now t1 is aligned to a 4-byte boundary
aligned:
    # Prepare 32-bit word with repeated bytes
    slli t3, a1, 8         # t3 = a1 << 8
    or t3, t3, a1          # t3 = (a1 << 8) | a1
    slli t3, t3, 16        # t3 = ((a1 << 8) | a1) << 16
    or t3, t3, a1          # t3 = (((a1 << 8) | a1) << 16) | a1

    # Check if the length is at least 4 bytes
    li t0, 4               # t0 = 4
    blt a2, t0, byte_loop  # If length < 4, skip to the byte loop

word_loop:
    sw t3, 0(t1)           # Write 4 bytes
    addi t1, t1, 4         # Increment pointer by 4
    addi a2, a2, -4        # Decrement length by 4
    bge a2, t0, word_loop  # If length >= 4, repeat

byte_loop:
    beqz a2, done          # If length is zero, return

    # Write remaining bytes one at a time
    sb a1, 0(t1)           # Write byte
    addi t1, t1, 1         # Increment pointer
    addi a2, a2, -1        # Decrement length
    bnez a2, byte_loop     # If length != 0, repeat

done:
    ret                    # Return
