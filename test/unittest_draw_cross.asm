
#this is the unittest for the function "draw_cross".

#input:
	# cross on field 3, 5 and 7
	
#expected output:
	# | | |X|
	# | |X| |
	# |X| | |

utest_draw_cross:	
	
	#draw a cross in the top right field
	li a3, 427
	li a4, 85
	li a7, 0xffffff 
	jal draw_cross
	
	#draw a cross in the field in the middle
	li a3, 256
	li a4, 256
	li a7, 0xffffff
	jal draw_cross

	#draw a cross in the bottom left field
	li a3, 85
	li a4, 427
	li a7, 0xffffff 
	jal draw_cross
	
	li a7, 10
	ecall
	
	
	
.include "tictactoe.asm"
