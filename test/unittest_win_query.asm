
#this is the unittest for the function "win_query"

#Input:
	#gamefield in current situation: Player 1(1) Player 2 (2)
	# |1|0|2|
	# |1|2|0|
	# |2|1|0|

#Expected output:
	# "Player 2 is the winner! Game over! New game : 1, End game: 2, Current score: 3, highest winstreak: 4

utest_win_query:
	#Step 1: load the field information in the storage
 
	li t1, 1
	sw t1, -100(sp)
	li t1, 0
	sw t1, -104(sp)
	li t1, 2
	sw t1, -108(sp)
	li t1, 1
	sw t1, -112(sp)
	li t1, 2
	sw t1, -116(sp)
	li t1, 0
	sw t1, -120(sp)
	li t1, 2
	sw t1, -124(sp)
	li t1, 1
	sw t1, -128(sp)	
	li t1, 0
	sw t1, -132(sp)
	li t1, 2
	sw t1, -244(sp)
	
	
	jal win_query
	
	li a7, 10
	ecall


.include "tictactoe.asm"
