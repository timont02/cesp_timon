
#this is the unittest for the function "draw_gamefield".

utest_draw_gamefield:	
	jal draw_gamefield
	
	li a7, 10
	ecall
	
	
	
.include "tictactoe.asm"