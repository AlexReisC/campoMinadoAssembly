.include "macros.asm"

.globl play

play:
	save_context
	move $s0, $a0 # board
	move $s1, $a1 # row
	move $s2, $a2 # colunm
	
	sll $t0, $s1, 5 # row*4*SIZE
	sll $t1, $s2, 2 # colunm*4
	add $t0, $t0, $t1 
	add $t0, $t0, $s0
	lw $t1, 0($t0)
	li $t2, -1
	beq $t1, $t2, hit_bomb
	
	li $t2, -2
	bne $t1, $t2, entry_if
	
	hit_bomb:
		move $v0, $zero
		jr $ra

	entry_if:
		# x = countAdjacentBoms(board, row, colunm)
		jal countAdjacentBombs
		move $s3, $v0
		sw $s3, 0($t0) # board[row][colunm] = x
		bne $s3, $zero, x_no_zero_p
	
	x_no_zero_p:
		jal revealNeighboringCells # revealNeighboringCells(board, row, colunm)
	
	li $t3, 1
	move $v0, $t3 # return 1
	jr $ra
