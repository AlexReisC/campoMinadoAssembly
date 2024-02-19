.include "macros.asm"

.globl checkVictory

checkVictory:
	save_context

	li $s1,0 # int count = 0
	move $s0, $a0 # $s0 = board
	li $s2,0 		# i = 0

#primeiro loop
	begin_for_i_cv: # for (int i = 0; i < SIZE; ++i)
		li $t0,SIZE  #size � o tamanho do board
		bge $s2,$t0,end_for_i_cv #s1 <= t0 continua repetindo

#segundo loop
	li $s3,0    # j = 0
	begin_for_j_cv:
		li $t0,SIZE
		bge $s3,$t0,end_for_j_cv
#codigo do interior dos 2 loops
	
	addi $s3, $s3, 1
	j begin_for_j_cv
	end_for_j_cv:
		addi $s2, $s2, 1
	
	j begin_for_i_cv
	end_for_i_cv:
		li $t0, SIZE
		li $t1, SIZE
		mult $t0, $t1 # SIZE * SIZE
		mflo $t2
		li $t1, BOMB_COUNT
		sub $t0, $t2, $t1 # SIZE * SIZE - BOM_COUNT
		slt $t3, $s1, $t0
		beq $t3, $zero, victory
		restore_context
		li $v0, 0 # return 0
		jr $ra
	
	victory:
		restore_context
		li $v0, 1 # return 1
		jr $ra

