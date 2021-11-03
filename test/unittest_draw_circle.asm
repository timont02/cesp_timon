
#this is the unittest for the function "draw_circle".

#input:
	# circle on field 2, 6 and 7
	
#expected output:
	# | |O| |
	# | | |O|
	# |O| | |

utest_draw_circle:	
	
	#draw a circle in the top right field
	li a3, 256
	li a4, 85
	li a5, 50
	li a7, 0xffffff 
	jal draw_circle
	
	#draw a circle in the field in the middle
	li a3, 427
	li a4, 256
	li a5, 50
	li a7, 0xffffff
	jal draw_circle

	#draw a circle in the bottom left field
	li a3, 85
	li a4, 427
	li a5, 50
	li a7, 0xffffff 
	jal draw_circle
	
	li a7, 10
	ecall
	
	
	
.include "tictactoe.asm"
