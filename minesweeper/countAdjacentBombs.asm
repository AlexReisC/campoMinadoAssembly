.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
	save_context
    move $s0, $a0 # $s0 = board
   	move $s1, $a1 # $s1 = row
	move $s2, $a2 # $s2 = column

	li $s3, 0 # count = 0 (number of bombs)
	addi $s4, $s1, -1 # i = row - 1
	begin_for_i_cb: # for (i = row - 1; i <= row + 1; i++)
		addi $t0, $s1, 1 # $t0 = row + 1
	   	bge $s4, $t0, end_for_i_cb # if (i > row + 1) break
    
	addi $s5, $s2, -1 # j = column - 1
	begin_for_j_cb: # for (j = column - 1; j <= column + 1; j++)
		addi $t0, $s2, 1 # $t0 = column + 1
	    bge $s5, $t0, end_for_j_cb # if (j > column + 1) break

	slt $t0, $s4, $zero # if (i >= 0)
	bne $t0, $zero, end_for_j_cb # break
	li $t1, SIZE
	slt $t0, $s4, $t1 # if(i < SIZE)
	beq $t0, $zero, end_for_j_cb # break
	slt $t0, $s5, $zero # if (j >= 0)
	bne $t0, $zero, end_for_j_cb # break
	slt $t0, $s5, $t1 # if (j < SIZE)
    beq $t0, $zero, end_for_j_cb # break
    sll $t0, $s4, 5 # i*4*SIZE
    sll $t1, $s5, 2 # j*4
    add $t0, $t0, $t1 # (i*4*SIZE + j*4)
    add $t0, $t0, $s0 # ((i*4)*SIZE + j*4) + &board
    lw $t1, 0($t0) # $t0 = board[i][j]
    li $t2, -1
    bne $t1, $t2, end_for_j_cb # if (board[i][j] != -1) break
    addi $s3, $s3, 1 # count++
    
    addi $s5, $s5, 1 # j++
    j begin_for_j_cb 
    end_for_j_cb:
    	addi $s4, $s4, 1 # i++
	
	j begin_for_i_cb
    end_for_i_cb:
    	move $v0, $s3 # return count
    	restore_context
    	jr $ra
    
