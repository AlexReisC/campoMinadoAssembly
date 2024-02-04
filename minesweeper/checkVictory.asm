.include "macros.asm"

.globl checkVictory
#AVISO: ESSE ARQUIVO N VEIO COMO CODIGO BASE

checkVictory:

save_context

li $s3,0 # int count = 0
move $s0, $a0 # $s0 = board
li $s1,0 		# i = 0

#primeiro loop
begin_for_i_it: # for (int i = 0; i < SIZE; ++i)

li $t0,SIZE  #size é o tamanho do board
bge $s1,$t0,end_for_i_it #s1 <= t0 continua repetindo

#segundo loop
li $s2,0    # j = 0
begin_for_j_it:
li $t0,SIZE
bge $s2,$t0,end_for_j_it
#codigo do interior dos 2 loops

bltz  #board  aumenta_count

j begin_for_i_it

aumenta_count:
addi $s3,$s3,1 #aumentar count



