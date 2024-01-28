.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
save_context
    move $s0, $a0 # $s0 = board
    move $s1, $a1 # $s1 = row
    move $s2, $a2 # $s2 = column

    li $s3, 0 # count = 0 (number of bombs)
    addi $s4, $s1, -1 # i = row - 1
    begin_for_i_it: # for (i = row - 1; i <= row + 1; i++)
        addi $t0, $s1, 1 # $t0 = row + 1
        bge $s4, $t0, end_for_i_it # if (i > row + 1) break
    
    addi $s5, $s2, -1 # j = column - 1
    begin_for_j_it: # for (j = column - 1; j <= column + 1; j++)
        addi $t1, $s2, 1 # $t1 = column + 1
        bge $s5, $t1, end_for_j_it # if (j > column + 1) break

    