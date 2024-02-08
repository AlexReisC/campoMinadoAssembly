.include "macros.asm"

.globl play

play:
	move $s0, $a0 # board
	move $s1, $a1 # row
	move $s2, $a2 # colunm
	sll $t0, $s1, 5 # row*4*SIZE
	sll $t1, $s2, 2 # colunm*4
	add $t0, $t0, $t1 
	add $t0, $t0, $s0
	sw $t0, 0($t0)
	li $t1, -1
	beq $t0, $t1, end_play_hit_bomb
	
	addi $t1, $t1, -1
	bne $t0, $t1, continue_game
	
	# x = countAdjacentBoms(boar, row, colunm)
	# if(!x)
	
	end_play_hit_bomb:
	move $v0, $zero
	jr $ra
	
	continue_game:
	li $t3, 1
	move $v0, $t3 
	jr $ra