.include "macros.asm"
.globl revealNeighboringCells

revealNeighboringCells:
 	save_context
	move $s0, $a0 # $s0 = board
	move $s1, $a1 # $s1 = row
	move $s2, $a2 # $s2 = column

	addi $s3, $s1, -1 # i = row - 1
	begin_for_i_rv: # for (i = row - 1; i <= row + 1; i++)
		addi $t0, $s1, 1 # $t0 = row + 1
    	bge $s3, $t0, end_for_i_rv # if (i > row + 1) break
  
	addi $s4, $s2, -1 # j = column - 1
	begin_for_j_rv: # for (j = column - 1; j <= column + 1; j++)
    	addi $t0, $s2, 1 # $t1 = column + 1
    	bge $s4, $t0, end_for_j_rv # if (j > column + 1) break

	slt $t0, $s3, $zero # if (i >= 0)
	bne $t0, $zero, end_for_i_rv # break
	li $t1, SIZE
	slt $t0, $s3, $t1 # if(i < SIZE)
	beq $t0, $zero, end_for_i_rv # break
	slt $t0, $s4, $zero # if (j >= 0)
	bne $t0, $zero, end_for_j_rv # break
	slt $t0, $s4, $t1 # if (j < SIZE)
	beq $t0, $zero, end_for_j_rv # break
	sll $t0, $s3, 5 # i*4*SIZE
	sll $t1, $s4, 2 # j*4
	add $t0, $t0, $t1 # (i*4*SIZE + j*4)
	add $s5, $t0, $s0 # ((i*4)*SIZE + j*4) + &board
 	lw $t1, 0($s5) # $t0 = board[i][j]
	li $t2, -2
	bne $t1, $t2, end_for_j_rv # if (board[i][j] != -2) break
  
	move $a1, $s3
	move $a2, $s4
	jal countAdjacentBombs
	move $t1, $v0 # x = countAdjacentBombs(board, i, j)
	sw $t1, 0($s5) # board[i][j] = x
	beq $t1, $zero, x_zero_rv
	
	addi $s4, $s4, 1
	j begin_for_j_rv
	
	end_for_j_rv:
		addi $s3, $s3, 1
	
	j begin_for_i_rv
	end_for_i_rv:
		restore_context
    	jr $ra
	  
	x_zero_rv:
		jal revealNeighboringCells
		restore_context
		jr $ra