
# this is the unittest for the function "bot_rule_1" and every function, which is connected with the function

#input:
	# |O|O| |
	# | |X|X|
	# | |O| |

#expected output:
	# | | | |
	# |X| | |
	# | | | |
	
	# "Player 2 is the winner! Game over! New game : 1, End game: 2, Current score: 3, highest winstreak: 4

utest_bot_rule_1_:

	li t1, 1
	sw t1, -100(sp)
	li t2, 1
	sw t2, -104(sp)
	li t3, 0
	sw t3, -108(sp)
	li t4, 0
	sw t4, -112(sp)
	li t5, 2
	sw t5, -116(sp)
	li t6, 2
	sw t6, -120(sp)
	li a1, 0
	sw a1, -124(sp)
	li a2, 1
	sw a2, -128(sp)	
	li a3, 0
	sw a3, -132(sp)
	li a6, 1




	
	jal bot_rule_1
	
	li a7, 10
	ecall
	
.include "tictactoe.asm"
