#storage locations:
		# -500 = ra
		# -400 = current player
		# -132 - -100 = field taken or not and from wich player: #-100 = field 1; -104 = field 2; etc. ...
		# -20 = a0 = number of the field (from input)
		# -204 = ra for draw gamefield return
		# -208 = wins of Player 1 in current session
		# -212 = wins of Player 2 in current session
		# -216 = current winstreak
		# -220 = player of the winstreak
		# -224 = number of used fields
		# -228 = ra for draw_cross
		# -232 = ra in bot function
		# -236 = bot or human
		# -240 = test field counter of the bot function
		# -244 = who is the real player human (1), bot(2), or testbot(3)
		# -248 = current rule counter
		# -252 - 372 = storage for registers
	
		
#all used text strings	
.data
player1_text: .string  "Player1 must select a field. "
player2_text: .string  "Player2 must select a field. "
bot_or_human_text: .string "Welcome! Do you want to play against a bot or a human? Press 1 for a bot and 2 for a human."
error_message_1: .string  "Field is already taken. Please enter e new number. "
error_message_2: .string  "Your number was not between 1 and 9. Please enter a new number. "
error_message_3: .string  "Your number was not between 1 and 4. Please enter a new number. "
error_message_4: .string "Wrong number, please try agein."
game_over_1: .string "Player 1 is the winner! Game over! "
game_over_2: .string "Player 2 is the winner! Game over! "
game_over_3: .string " New game: 1, End game: 2, Current score: 3, highest winstreak: 4 " 
game_over_4: .string "All fields used. Game over. "        
new_game_text: .string "You started a new game! "
score_1: .string " Player 1: "
score_2: .string " Player 2: "
score_3: .string "Score: "
winstreak_1: .string "Current winstreak: Player 1: "
winstreak_2: .string "Current winstreak: Player 2: "

.text

.eqv DISPLAY_ADDRESS 0x10010000
.eqv DISPLAY_WIDTH 512
.eqv DISPLAY_HEIGHT 512


#function for the settings before the start of the first game (draw gamefield etc.)	
start_game: 
	sw ra, -500(sp) #store the return address
	jal bot_or_human
	jal ra, draw_gamefield
	li a5, -1
	sw a5, -224(sp)
	j game

#function to start a game	
game: 
	li t6, 1
	sw t6, -400(sp) #save the first player as the current player
	jal win_query
	

#Step 1: win query
win_query:
	
	#Step 1.1 load all field information in registers
	lw t1, -100(sp)
	lw t2, -104(sp)
	lw t3, -108(sp)
	lw t4, -112(sp)
	lw t5, -116(sp)
	lw t6, -120(sp)
	lw a1, -124(sp)
	lw a2, -128(sp)	
	lw a3, -132(sp)
	
	#Step 1.2 the win query
	#Step 1.2.1 check all rows
	row1:
		beq t1, t2, step1_2 #are the users on field 1 and 2 equal?
		j row2 #if not, check the next row
		step1_2:
			beq t2, t3, step1_3 #are the users on field 2 and 3 equal?
			j row2 #if not, check the next row
			step1_3:
				li a4, 2 
				beq a4, t3, bot_or_not_2 #is the user on both fields player 2?
				li a4, 1
				beq a4, t3, bot_or_not_1 #is the user on both fields player 1?			
				j row2 #if not, check the next row
				
	row2:
		beq t4, t5, step2_2 #are the users on field 4 and 5 equal?
		j row3 #if not, check the next row
		step2_2:
			beq t5, t6, step2_3 #are the users on field 5 and 6 equal?
			j row3 #if not, check the next row
			step2_3:
				li a4, 2
				beq a4, t6, bot_or_not_2 #is the user on both fields player 2?
				li a4, 1
				beq a4, t6, bot_or_not_1 #is the user on both fields player 1?		
				j row3 #if not, check the next row
				
	row3:
		beq a1, a2, step3_2 #are the users on field 7 and 8 equal?
		j collumn1 #if not, check the the collumns
		step3_2:
			beq a2, a3, step3_3 #are the users on field 8 and 9 equal?
			j collumn1 #if not, check the the collumns
			step3_3:
				li a4, 2
				beq a4, a3, bot_or_not_2 #is the user on both fields player 2?
				li a4, 1
				beq a4, a3, bot_or_not_1 #is the user on both fields player 1?		  
				j collumn1 #if not, check the the collumns
	
	
	#Step 1.2.2 check all collumns			
	collumn1:
		beq t1, t4, step4_2 #are the users on field 1 and 4 equal?
		j collumn2 #if not, check the next collumn
		step4_2:
			beq t4, a1, step4_3 #are the users on field 4 and 7 equal?
			j collumn2#if not, check the next collumn
			step4_3:
				li a4, 2
				beq a4, a1, bot_or_not_2 #is the user on both fields player 2?
				li a4, 1
				beq a4, a1, bot_or_not_1 #is the user on both fields player 1?		
				j collumn2 #if not, check the next collumn
				
	collumn2:
		beq t2, t5, step5_2 #are the users on field 2 and 5 equal?
		j collumn3 #if not, check the next collumn
		step5_2:
			beq t5, a2, step5_3 #are the users on field 5 and 8 equal?
			j collumn3 #if not, check the next collumn
			step5_3:
				li a4, 2
				beq a4, a2, bot_or_not_2 #is the user on both fields player 2?
				li a4, 1
				beq a4, a2, bot_or_not_1 #is the user on both fields player 1?		
				j collumn3 #if not, check the next collumn
				
	collumn3:
		beq t3, t6, step6_2 #are the users on field 3 and 6 equal?
		j diagonal1  #if not, check the diagonals
		step6_2:
			beq t6, a3, step6_3 #are the users on field 6 and 9 equal?
			j diagonal1  #if not, check the diagonals
			step6_3:
				li a4, 2
				beq a4, a3, bot_or_not_2 #is the user on both fields player 2?
				li a4, 1
				beq a4, a3, bot_or_not_1 #is the user on both fields player 1?		 
				j diagonal1 #if not, check the diagonals
	
	#Step 1.2.3 check the two diagonals			
	diagonal1:
		beq t1, t5, step7_2 #are the users on field 1 and 5 equal?
		j diagonal2 #if not, check the next diagonal
		step7_2:
			beq t5, a3, step7_3 #are the users on field 5 and 9 equal?
			j diagonal2 #if not, check the next diagonal
			step7_3:
				li a4, 2
				beq a4, a3, bot_or_not_2  #is the user on both fields player 2?
				li a4, 1
				beq a4, a3, bot_or_not_1 #is the user on both fields player 1?		
				j diagonal2 #if not, check the next diagonal
				
	diagonal2:
		beq t3, t5, step8_2 #are the users on field 3 and 5 equal?
		lw a0, -244(sp) 
		li a1, 3
		beq a0, a1, bot	#is the current player a bot with a test field?
		j termination_condition 
		step8_2:
			beq t5, a1, step8_3 #are the users on field 5 and 7 equal?
			lw a0, -244(sp)
			li a1, 3
			beq a0, a1, bot	#is the current player a bot with a test field?	 
			j termination_condition
			step8_3:
				li a4, 2
				beq a4, a1, bot_or_not_2 #is the user on both fields player 2?
				li a4, 1
				beq a4, a1, bot_or_not_1 #is the user on both fields player 1?		
				lw a0, -244(sp)
				li a1, 3
				beq a0, a1, bot	#is the current player a bot with a test field?	(this branch is only used if there is no possible win option for the bot or player 1)		
				j termination_condition


	#Step 1.3: check, if the current player is a bot or a human for player 1
	
	#is the current player a bot (testfield) or a human
	bot_or_not_1: 
		lw a0, -244(sp)
		li a1, 3
		beq a0, a1, block_enemy # the current player is the bot with a test field, now the bot knows that the player can win and he has to block him
		li a1, 1
		beq a0, a1, player_1_winner # the current player is the human and he will win
		
	#is the current player a bot (testfield) or a human for player 2
	bot_or_not_2: 
		lw a0, -244(sp)
		li a1, 3
		beq a0, a1, win_the_game # the current player is the bot with a test field, now the bot knows that the player can win and he has to block him
		li a1, 0
		beq a0, a1, player_2_winner # the current player is the human and he will win
		li a1, 2
		beq a0, a1, player_2_winner # the current player is the human and he will win
		
		
				
	#Step 1.4: check, if all fields are used
	termination_condition:
		lw t5, -224(sp)
		addi t5, t5, 1
		sw t5, -224(sp)
		li t6, 9
		beq, t5, t6, end_game_2 #if all field are used (9 fields), the game must restart
		li t5, 0
		li t6, 0
		j player_select #if not, the programm can jump to the next step
	
	#winner functions
	
	#player 1 is the winner
	player_1_winner:
		lw a0, -208(sp) 
		addi a0, a0, 1 #add 1 win
		sw a0, -208(sp) #load the win to the score on storage
		lw a0, -220(sp) #load the player of the winstreak
		li a1, 1
		beq a0, a1, player_1_winstreak 
		bne a0, a1, player_1_new_winstreak 
		
		#if the player has already a winstreak, the winstreak counter mus get increased by one
		player_1_winstreak:
				lw a2, -216(sp) 
				addi a2, a2, 1
				sw a2, -216(sp) #load the win to the score on storage
				j exit_player_1_winner
		#if the player has no winstrak, there must be a new one and the winstreak of the other player must get deleated
		player_1_new_winstreak:
				li a0, 1
				sw a0, -216(sp) #load the win to the score on storage
				sw a0, -220(sp) #safe the new winstreak player
				j exit_player_1_winner
		exit_player_1_winner:
			la a0, game_over_1
			li a7, 4
			ecall #print the text from game_over_1
			j end_menu	

	#player 2 is the winner	
	player_2_winner:
		lw a0, -212(sp)
		addi a0, a0, 1 #add 1 win
		sw a0, -212(sp)
		lw a0, -220(sp) #load the player of the winstreak
		li a1, 2
		beq a0, a1, player_2_winstreak
		bne a0, a1, player_2_new_winstreak
	
		#if the player has already a winstreak, the winstreak counter mus get increased by one
		player_2_winstreak:
				lw a2, -216(sp) 
				addi a2, a2, 1
				sw a2, -216(sp) #load the win to the score on storage
				j player_2_winner_exit

		#if the player has no winstrak, there must be a new one and the winstreak of the other player must get deleated
		player_2_new_winstreak:
				li a0, 1
				sw a0, -216(sp) #load the win to the score on storage
				li a0, 2
				sw a0, -220(sp) #safe the new winstreak player
				j player_2_winner_exit
		player_2_winner_exit:
			la a0, game_over_2
			li a7, 4
			ecall #print the text from game_over_2	
			j end_menu	


		#the menu in the console at the end of a game
		end_menu:
			la a0, game_over_3
			li a7, 4
			ecall #print the text from game_over_3	
			li a7, 5
			ecall #read the input number for the menu navigation
			li a4, 1
			beq a4, a0, new_game
			li a4, 2
			beq a4, a0, end_game	
			li a4, 3
			beq a4, a0, score
			li a4, 4
			beq a4, a0, winstreak
			la a0, error_message_3 #no correct input number -> error message
			li a7, 4
			ecall #print the text from error_message_3
			j end_menu #jump to the begin of the function for new input	
			
		
		#the functions for the different options of the end menu
		
		#if the user wants to start a new game
		new_game: 
			#reset all fields on the display
			li a7, 0x000000 #color black
			j p1_top_left #now there will be a cross and a circle drawn on every field with the color black, so the symbols of the game are hidden on the display
			
			new_game_2:
				#reset all field information
				li t1, 0
				sw t1, -100(sp)
				sw t1, -104(sp)
				sw t1, -108(sp)
				sw t1, -112(sp)
				sw t1, -116(sp)
				sw t1, -120(sp)
				sw t1, -124(sp)
				sw t1, -128(sp)	
				sw t1, -132(sp)

				#reset the field counter
				sw t1, -224(sp) 
				#reset the bot 
				sw t1, -136(sp)
				sw t1, -140(sp)
				sw t1, -144(sp)
				
				li a5, -1
				sw a5, -224(sp)
				li a7, 1
				sw a7, -248(sp) # that the bot can jump in rule 1
				li a7, 1
				sw a7, -236(sp)
				#reset all registers
				li t1, 0
				li t1, 0
				li t2, 0
				li t3, 0
				li t4, 0
				li t5, 0
				li t6, 0
				li a1, 0
				li a2, 0
				li a3, 0
				li a4, 0
				li a5, 0
				li a6, 0
				li s0, 0
				li s1, 0
				li s2, 0
				li s3, 0
				li s4, 0
				li s5, 0
				li s6, 0
				li s7, 0
				li s8, 0
				li s9, 0
				li s10, 0
				la a0, new_game_text
				li a7, 4
				ecall #print the text from new_game
				j game
		
		#if the user wants to end the game	
		end_game:
			addi a7, zero, 10
			ecall
			
		end_game_2:
			la a0, game_over_4
			li a7, 4
			ecall #print the text from game_over_4
			j end_menu
		
		#if the user wants to see the score	
		score:
			la a0, score_3
			li a7, 4
			ecall #print the text from score_3	
			la a0, score_1
			li a7, 4
			ecall #print the text from score_1
			lw a0, -208(sp)
			li a7, 1
			ecall #print the score of player 1
			la a0, score_2
			li a7, 4
			ecall #print the text from score_2
			lw a0, -212(sp)
			li a7, 1
			ecall #print the score of player 
			j end_menu
		
		#if the user wants to see the winstreak
		winstreak:	
			lw a0, -220(sp)
			li a1, 1
			beq a0, a1, print_player_1
			li a1, 2
			beq a0, a1, print_player_2
			print_player_1:
					la a0, winstreak_1
					li a7, 4
					ecall #print the text from score_1	
					j end_winstreak

			print_player_2:
					la a0, winstreak_2
					li a7, 4
					ecall #print the text from score_2	
					j end_winstreak
			end_winstreak:
				lw a0, -216(sp)
				li a7, 1
				ecall #print the winstreak
				j end_menu
	
	
#Step 2: select the current player
player_select:
	li t4, 1
	li t5, 2
	lw t6, -400(sp)
	beq t4, t6, player_1_loop
	beq t5, t6, player_2_loop
	
	
	
#Step 3: the two differnt players
	
player_1_loop:
	la a0, player1_text 
	li a7, 4
	ecall #print the text "PlayerX must select a field." on the console
	li a7, 5
	ecall #read the Number of the field as an integer from the console
	sw a0, -20(sp) # store the input
	
	jal ra, rules #jump to the rules
	li a7, 0xffffff #color of player 
	#which field is the current field?
	li t3, 1
	beq t3, a0, p1_top_left
	addi t3, t3, 1
	beq t3, a0, p1_top_middle
	addi t3, t3, 1
	beq t3, a0, p1_top_right
	addi t3, t3, 1
	beq t3, a0, p1_middle_left
	addi t3, t3, 1
	beq t3, a0, p1_middle_middle
	addi t3, t3, 1
	beq t3, a0, p1_middle_right
	addi t3, t3, 1
	beq t3, a0, p1_bottom_left
	addi t3, t3, 1
	beq t3, a0, p1_bottom_middle
	addi t3, t3, 1
	beq t3, a0, p1_bottom_right
	beq zero, zero, cond_exit

player_2_loop:
	lw a0, -236(sp) #load if bot or human
	li a1, 1
	beq a0, a1, bot
	la a0, player2_text
	li a7, 4
	ecall
	li a7, 5
	ecall #read the Number of the fiald as an integer from the console
	sw a0, -20(sp) # store the input	
	jal ra, rules #jump to the rules
	li a7, 0xffffff #color of player 
	#which field is the current field?
	li t3, 1
	beq t3, a0, p2_top_left
	addi t3, t3, 1
	beq t3, a0, p2_top_middle
	addi t3, t3, 1
	beq t3, a0, p2_top_right
	addi t3, t3, 1
	beq t3, a0, p2_middle_left
	addi t3, t3, 1
	beq t3, a0, p2_middle_middle
	addi t3, t3, 1
	beq t3, a0, p2_middle_right
	addi t3, t3, 1
	beq t3, a0, p2_bottom_left
	addi t3, t3, 1
	beq t3, a0, p2_bottom_middle
	addi t3, t3, 1
	beq t3, a0, p2_bottom_right
	beq zero, zero, cond_exit



#Step 4: the rules
rules:
	sw ra, -500(sp) #store the return address
	
	#rule 1: if the input number is not between 1 and 9, you must enter a new one
	li t1, 0
	blt a0, t1, forbidden_number
	li t1, 10
	bge a0, t1, forbidden_number
	j rule_2
	
	forbidden_number:
		la a0, error_message_2 #Print the error message "Your number was not between 1 and 9. Please enter a new number." on the console.
		li a7, 4
		ecall #Print the error message "Your number was not between 1 and 9. Please enter a new number." on the console.
		lw a0, -20(sp) # load the field numvber from storage
		lw ra, -500(sp) #load address of main function
		jalr zero, -16(ra) #return to the player loop 
	
	#rule 2: if a field is already claimed, you cant use it
	# a0: this is the field, wich the player want's to claim
	rule_2:
		jal ra, offset_determination
	
		li a3, 0
		beq a1, a3, cond_exit #if the field is empty, everything is ok
		la a0, error_message_1 
		li a7, 4
		ecall #Print the errormessage "Field is already taken. Please enter e new number." on the console.
		lw ra, -500(sp) #load address of main function
		jalr zero, -16(ra) #return to the player loop 
	
	
		#wich sp offset do we need?
		offset_determination:
			li t2, 1
			beq a0, t2, offset_1
			li t2, 2
			beq a0, t2, offset_2
			li t2, 3
			beq a0, t2, offset_3
			li t2, 4
			beq a0, t2, offset_4
			li t2, 5
			beq a0, t2, offset_5
			li t2, 6
			beq a0, t2, offset_6
			li t2, 7
			beq a0, t2, offset_7
			li t2, 8
			beq a0, t2, offset_8
			li t2, 9
			beq a0, t2, offset_9
	
			offset_1:
				lw a1, -100(sp) #load the information about the field in a1
				ret
			offset_2:
				lw a1, -104(sp) #load the information about the field in a1
				ret
			offset_3:
				lw a1, -108(sp) #load the information about the field in a1
				ret	
			offset_4:
				lw a1, -112(sp) #load the information about the field in a1
				ret	
			offset_5:
				lw a1, -116(sp) #load the information about the field in a1
				ret		
			offset_6:
				lw a1, -120(sp) #load the information about the field in a1
				ret	
			offset_7:
				lw a1, -124(sp) #load the information about the field in a1
				ret	
			offset_8:
				lw a1, -128(sp) #load the information about the field in a1
				ret	
			offset_9:
				lw a1, -132(sp) #load the information about the field in a1
				ret		


	cond_exit:
		lw ra, -500(sp) #load Address of main function
		ret



#Step 5: draw the players on the fild

#draw instruction for player 1 for every field
p1_top_left:
	li a3, 85
	li a4, 85
	li a5, 50
	jal draw_circle
	li a5, 0x000000
	beq a7, a5, p2_top_left #condition for reset the field
	li t6, 1
	sw t6, -100(sp) #now the field is taken (and stored at the memory)
	li t6, 2
	sw t6, -400(sp) #now the other player is the current player
	beq zero, zero, win_query
	
p2_top_left:
	li a3, 85
	li a4, 85
	jal draw_cross
	li a5, 0x000000
	beq a7, a5, p1_top_middle #condition for reset the field
	li t6, 2
	sw t6, -100(sp) #now the field is taken (and stored at the memory)
	li t6, 1
	sw t6, -400(sp) #now the other player is the current player
	li t6, 0
	sw t6, -244(sp) # reset the testbot or bot 
	li a4, 1
	sw a4, -248(sp) # now the current rule is rule 1
	beq zero, zero, win_query
	
p1_top_middle:
	li a3, 256
	li a4, 85
	li a5, 50
	jal draw_circle
	li a5, 0x000000
	beq a7, a5, p2_top_middle #condition for reset the field
	li t6, 1
	sw t6, -104(sp) #now the field is taken (and stored at the memory)
	li t6, 2
	sw t6, -400(sp) #now the other player is the current player
	beq zero, zero, win_query
	
p2_top_middle:
	li a3, 256
	li a4, 85
	jal draw_cross
	li a5, 0x000000
	beq a7, a5, p1_top_right #condition for reset the field
	li t6, 2
	sw t6, -104(sp) #now the field is taken (and stored at the memory)
	li t6, 1
	sw t6, -400(sp) #now the other player is the current player
	li t6, 0
	sw t6, -244(sp) # reset the testbot or bot 
	li a4, 1
	sw a4, -248(sp) # now the current rule is rule 1
	beq zero, zero, win_query
	
	
p1_top_right:
	li a3, 427
	li a4, 85
	li a5, 50
	jal draw_circle
	li a5, 0x000000
	beq a7, a5, p2_top_right #condition for reset the field
	li t6, 1
	sw t6, -108(sp) #now the field is taken (and stored at the memory)
	li t6, 2
	sw t6, -400(sp) #now the other player is the current player
	beq zero, zero, win_query
	
p2_top_right:
	li a3, 427
	li a4, 85
	jal draw_cross
	li a5, 0x000000
	beq a7, a5, p1_middle_left #condition for reset the field
	li t6, 2
	sw t6, -108(sp) #now the field is taken (and stored at the memory)
	li t6, 1
	sw t6, -400(sp) #now the other player is the current player
	li t6, 0
	sw t6, -244(sp) # reset the testbot or bot 
	li a4, 1
	sw a4, -248(sp) # now the current rule is rule 1
	beq zero, zero, win_query
	
p1_middle_left:
	li a3, 85
	li a4, 256
	li a5, 50
	jal draw_circle
	li a5, 0x000000
	beq a7, a5, p2_middle_left #condition for reset the field
	li t6, 1
	sw t6, -112(sp) #now the field is taken (and stored at the memory)
	li t6, 2
	sw t6, -400(sp) #now the other player is the current player
	beq zero, zero, win_query
	
p2_middle_left:
	li a3, 85
	li a4, 256
	jal draw_cross
	li a5, 0x000000
	beq a7, a5, p1_middle_middle #condition for reset the field
	li t6, 2
	sw t6, -112(sp) #now the field is taken (and stored at the memory)
	li t6, 1
	sw t6, -256(sp) #now the field is taken (and stored at the memory)
	li t6, 1
	sw t6, -400(sp) #now the other player is the current player#
	li t6, 0
	sw t6, -244(sp) # reset the testbot or bot 
	li a4, 1
	sw a4, -248(sp) # now the current rule is rule 1
	beq zero, zero, win_query		

p1_middle_middle:
	li a3, 256
	li a4, 256
	li a5, 50
	jal draw_circle
	li a5, 0x000000
	beq a7, a5, p2_middle_middle #condition for reset the field
	li t6, 1
	sw t6, -116(sp) #now the field is taken (and stored at the memory)
	li t6, 2
	sw t6, -400(sp) #now the other player is the current player
	beq zero, zero, win_query
	
p2_middle_middle:
	li a3, 256
	li a4, 256
	jal draw_cross
	li a5, 0x000000
	beq a7, a5, p1_middle_right #condition for reset the field
	li t6, 2
	sw t6, -116(sp) #now the field is taken (and stored at the memory)
	li t6, 1
	sw t6, -400(sp) #now the other player is the current player
	li t6, 0
	sw t6, -244(sp) # reset the testbot or bot 
	li a4, 1
	sw a4, -248(sp) # now the current rule is rule 1
	beq zero, zero, win_query		

p1_middle_right:
	li a3, 427
	li a4, 256
	li a5, 50
	jal draw_circle
	li a5, 0x000000
	beq a7, a5, p2_middle_right #condition for reset the field
	li t6, 1
	sw t6, -120(sp) #now the field is taken (and stored at the memory)
	li t6, 2
	sw t6, -400(sp) #now the other player is the current player
	beq zero, zero, win_query
	
p2_middle_right:
	li a3, 427
	li a4, 256
	jal draw_cross
	li a5, 0x000000
	beq a7, a5, p1_bottom_left #condition for reset the field
	li t6, 2
	sw t6, -120(sp) #now the field is taken (and stored at the memory)
	li t6, 1
	sw t6, -400(sp) #now the other player is the current player
	li t6, 0
	sw t6, -244(sp) # reset the testbot or bot 
	li a4, 1
	sw a4, -248(sp) # now the current rule is rule 1
	beq zero, zero, win_query			
		
p1_bottom_left:
	li a3, 85
	li a4, 427
	li a5, 50
	jal draw_circle
	li a5, 0x000000
	beq a7, a5, p2_bottom_left #condition for reset the field
	li t6, 1
	sw t6, -124(sp) #now the field is taken (and stored at the memory)
	li t6, 2
	sw t6, -400(sp) #now the other player is the current player
	beq zero, zero, win_query
	
p2_bottom_left:
	li a3, 85
	li a4, 427
	jal draw_cross
	li a5, 0x000000
	beq a7, a5, p1_bottom_middle #condition for reset the field
	li t6, 2
	sw t6, -124(sp) #now the field is taken (and stored at the memory)
	li t6, 1
	sw t6, -400(sp) #now the other player is the current player
	li t6, 0
	sw t6, -244(sp) # reset the testbot or bot 
	li a4, 1
	sw a4, -248(sp) # now the current rule is rule 1
	beq zero, zero, win_query	
	

p1_bottom_middle:
	li a3, 256
	li a4, 427
	li a5, 50
	jal draw_circle
	li a5, 0x000000
	beq a7, a5, p2_bottom_middle #condition for reset the field
	li t6, 1
	sw t6, -128(sp) #now the field is taken (and stored at the memory)
	li t6, 2
	sw t6, -400(sp) #now the other player is the current player
	beq zero, zero, win_query

p2_bottom_middle:
	li a3, 256
	li a4, 427
	jal draw_cross
	li a5, 0x000000
	beq a7, a5, p1_bottom_right #condition for reset the field
	li t6, 2
	sw t6, -128(sp) #now the field is taken (and stored at the memory)
	li t6, 1
	sw t6, -400(sp) #now the other player is the current player
	li t6, 0
	sw t6, -244(sp) # reset the testbot or bot
	li a4, 1
	sw a4, -248(sp) # now the current rule is rule 1 
	beq zero, zero, win_query	
	

p1_bottom_right:
	li a3, 427
	li a4, 427
	li a5, 50
	jal draw_circle
	li a5, 0x000000
	beq a7, a5, p2_bottom_right #condition for reset the field
	li t6, 1
	sw t6, -132(sp) #now the field is taken (and stored at the memory)
	li t6, 2
	sw t6, -400(sp) #now the other player is the current player
	beq zero, zero, win_query	
p2_bottom_right:
	li a3, 427
	li a4, 427
	jal draw_cross
	li a5, 0x000000
	beq a7, a5, new_game_2 #jump back the new_game
	li t6, 2
	sw t6, -132(sp) #now the field is taken (and stored at the memory)
	li t6, 1
	sw t6, -400(sp) #now the other player is the current player
	li t6, 0
	sw t6, -244(sp) # reset the testbot or bot 
	li a4, 1
	sw a4, -248(sp) # now the current rule is rule 1
	beq zero, zero, win_query	


#are two humans playing or a bot and a human?
bot_or_human:
	la a0, bot_or_human_text
	li a7, 4
	ecall
	li a7, 5
	ecall
	li a7, 1
	beq a7, a0, bot_select
	li a7, 2
	beq a7, a0, human_select
	la, a0, error_message_4
	li a7, 4
	ecall
	ret
bot_select: #a bot got selected
	li a7, 1
	sw a7, -248(sp) # that the bot can jump in rule 1
	li a7, 1
	sw a7, -236(sp)
	la a7, start_game
	jalr zero, 8(a7)
	
human_select: #two humans got selected
	li a7, 2
	sw a7, -236(sp)	
	la a7, start_game
	jalr zero, 8(a7)







#########################################################   bot   ######################################################### 







bot:
	#you dont need to save any registers here (except ra), because the information in the registers arte useless after the bot function

	sw ra, -232(sp)
	
	#load all field information
	lw t1, -100(sp)
	lw t2, -104(sp)
	lw t3, -108(sp)
	lw t4, -112(sp)
	lw t5, -116(sp)
	lw t6, -120(sp)
	lw a1, -124(sp)
	lw a2, -128(sp)	
	lw a3, -132(sp)
	
	lw t0, -224(sp) #load the field counter
	lw a6, -240(sp) #load the given test field
	
	# the bot must reset the last test field
	li a0, 1
	beq a0, a6, reset_field_1
	li a0, 2
	beq a0, a6, reset_field_2
	li a0, 3
	beq a0, a6, reset_field_3
	li a0, 4
	beq a0, a6, reset_field_4
	li a0, 5
	beq a0, a6, reset_field_5
	li a0, 6
	beq a0, a6, reset_field_6
	li a0, 7
	beq a0, a6, reset_field_7
	li a0, 8
	beq a0, a6, reset_field_8
	li a0, 9
	beq a0, a6, reset_field_9
		
increase_testfield_counter: #increase the counter of the test fields (its important for the bot to know, which field he must test next)
	addi a6, a6, 1 #next field
	
	li a4, 1
	beq a4, t0, first_move #the first move of the bot (field counter is 1), there are special rules
	
	#wich rule is the current rule?
	lw s1, -248(sp)
	beq a4, s1, bot_rule_1
	li a4, 2
	beq a4, s1, bot_rule_2
	li a4, 3
	beq a4, s1, bot_rule_3
	li a4, 4
	beq a4, s1, bot_rule_4	
	
	first_move: #if the field in the middle (field 5) is empty, the bot must claim it. If its taken, he must claim field 1.
		li a4, 0
		beq a4, t5, place_middle
		bne a4, t5, place_in_corner_1
			place_middle:
				li a7, 0xffffff #color of player 2 
				j p2_middle_middle
			place_in_corner_1:
				li a7, 0xffffff #color of player 2 
				j p2_top_left	

#rule 1: if the bot can win, he should do this				
bot_rule_1:
	li a4, 1
	sw a4, -248(sp) # now the current rule is rule 1
	li a4, 3
	sw a4, -244(sp) #here, the right player is th bot (2), because if the bot can win, he should instantly do it
	li a4, 0 # for the test, if the field is free
	li a0, 1
	beq a0, a6, field_1_free #is this field the current field?
	li a0, 2
	beq a0, a6, field_2_free #is this field the current field?
	li a0, 3
	beq a0, a6, field_3_free #is this field the current field?
	li a0, 4
	beq a0, a6, field_4_free #is this field the current field?
	li a0, 5
	beq a0, a6, field_5_free #is this field the current field?
	li a0, 6
	beq a0, a6, field_6_free #is this field the current field?
	li a0, 7
	beq a0, a6, field_7_free #is this field the current field?
	li a0, 8
	beq a0, a6, field_8_free #is this field the current field?
	li a0, 9
	beq a0, a6, field_9_free #is this field the current field?
	li a0, 0
	sw a0, -240(sp) #reset the test field
	li a0, 2
	sw a0, -248(sp) # now the current rule is rule 2
	li a6, 1
	sw a6, -240(sp) #reset the test field
	j bot_rule_2
		
	field_1_free:
		beq a4, t1, field_1_r1 #is this field free?
		j increase_testfield_counter
	field_2_free:
		beq a4, t2, field_2_r1 #is this field free?
		j increase_testfield_counter
	field_3_free:
		beq a4, t3, field_3_r1 #is this field free?
		j increase_testfield_counter
	field_4_free:
		beq a4, t4, field_4_r1 #is this field free?
		j increase_testfield_counter
	field_5_free:
		beq a4, t5, field_5_r1 #is this field free?
		j increase_testfield_counter
	field_6_free:
		beq a4, t6, field_6_r1 #is this field free?
		j increase_testfield_counter
	field_7_free:
		beq a4, a1, field_7_r1 #is this field free?
		j increase_testfield_counter
	field_8_free:
		beq a4, a2, field_8_r1 #is this field free?
		j increase_testfield_counter
	field_9_free:
		beq a4, a3, field_9_r1 #is this field free?
		li a0, 2
		sw a0, -248(sp) # now the current rule is rule 2
		li a6, 1
		sw a6, -240(sp) #reset the test field
		j bot_rule_2 # if field 9 isn't free, the bot can jump to the next rule
	
	win_the_game: #function in called from bot_or_not_2: if its called, the bot can win the game, if he claims the field, which is saved in -240(sp)
		lw a4, -240(sp)
		li a7, 0
		sw a7, -240(sp) #reset the test field counter
		li a7, 0xffffff #color of player 2 
		li a0, 1
		beq a0, a4, p2_top_left
		li a0, 2
		beq a0, a4, p2_top_middle
		li a0, 3
		beq a0, a4, p2_top_right
		li a0, 4
		beq a0, a4, p2_middle_left
		li a0, 5
		beq a0, a4, p2_middle_middle
		li a0, 6
		beq a0, a4, p2_middle_right
		li a0, 7
		beq a0, a4, p2_bottom_left
		li a0, 8
		beq a0, a4, p2_bottom_middle
		li a0, 9
		beq a0, a4, p2_bottom_right
		
#rule 2: if the enemy can win, the bot should block him		
bot_rule_2:
	li a4, 2
	sw a4, -248(sp) # now the current rule is rule 2
	li a4, 3
	sw a4, -244(sp) #here, the right player is th bot (2), because if the bot can win, he should instantly do it
	li a4, 0 # for the test, if the field is free
	li a0, 1
	beq a0, a6, field_1_free_r2 #is this field the current field?
	li a0, 2
	beq a0, a6, field_2_free_r2 #is this field the current field?
	li a0, 3
	beq a0, a6, field_3_free_r2 #is this field the current field?
	li a0, 4
	beq a0, a6, field_4_free_r2 #is this field the current field?
	li a0, 5
	beq a0, a6, field_5_free_r2 #is this field the current field?
	li a0, 6
	beq a0, a6, field_6_free_r2 #is this field the current field?
	li a0, 7
	beq a0, a6, field_7_free_r2 #is this field the current field?
	li a0, 8
	beq a0, a6, field_8_free_r2 #is this field the current field?
	li a0, 9
	beq a0, a6, field_9_free_r2 #is this field the current field?
	li a0, 0
	sw a0, -240(sp) #reset the test field 
	li a0, 3
	sw a0, -248(sp) # now the current rule is rule 3
	j bot_rule_3
	
	field_1_free_r2:
		beq a4, t1, field_1_r2 #is this field free?
		j increase_testfield_counter
	field_2_free_r2:
		beq a4, t2, field_2_r2 #is this field free?
		j increase_testfield_counter
	field_3_free_r2:
		beq a4, t3, field_3_r2 #is this field free?
		j increase_testfield_counter
	field_4_free_r2:
		beq a4, t4, field_4_r2 #is this field free?
		j increase_testfield_counter
	field_5_free_r2:
		beq a4, t5, field_5_r2 #is this field free?
		j increase_testfield_counter
	field_6_free_r2:
		beq a4, t6, field_6_r2 #is this field free?
		j increase_testfield_counter
	field_7_free_r2:
		beq a4, a1, field_7_r2 #is this field free?
		j increase_testfield_counter
	field_8_free_r2:
		beq a4, a2, field_8_r2 #is this field free?
		j increase_testfield_counter
	field_9_free_r2:
		beq a4, a3, field_9_r2 #is this field free?
		li a6, 1
		sw a6, -240(sp) #reset the test field
		li a0, 2
		sw a0, -248(sp) # now the current rule is rule 2
		j bot_rule_3 # if field 9 isn't free, the bot can jump to the next rule	

	
	#block the enemy, if he can win
	block_enemy:
		lw a4, -240(sp)
		li a7, 0
		sw a7, -240(sp) #reset the test field counter
		li a7, 0xffffff #color of player 2 
		li a0, 1
		beq a0, a4, p2_top_left
		li a0, 2
		beq a0, a4, p2_top_middle
		li a0, 3
		beq a0, a4, p2_top_right
		li a0, 4
		beq a0, a4, p2_middle_left
		li a0, 5
		beq a0, a4, p2_middle_middle
		li a0, 6
		beq a0, a4, p2_middle_right
		li a0, 7
		beq a0, a4, p2_bottom_left
		li a0, 8
		beq a0, a4, p2_bottom_middle
		li a0, 9
		beq a0, a4, p2_bottom_right
	
	
#rule 3: if there are exactly 3 fields used and the enemy (player 1) has 2 corners claimed and the bot has placed his field in the middle (field 5), the bot must use field 2, 4, 6 or 8
bot_rule_3:
	li a4, 3
	sw a4, -248(sp) # now the current rule is rule 3
	li s3, 0 # reset the corner counter
	li s2, 3
	bne s2, t0, bot_rule_4
	li a4, 1
	beq a4, t1, corner_counter_1 # is field 1 taken by player 1?
	beq a4, t3, corner_counter_2 # is field 3 taken by player 1?
	beq a4, a1, corner_counter_3 # is field 7 taken by player 1?
	beq a4, a3, corner_counter_4 # is field 9 taken by player 1?
	
	li s5, 2
	beq s3, s5, bot_rule_3_1 # does player 1 has exatly 2 corners?
	j bot_rule_4 # here are  no modifications needed, because we dont use field counter, testfields etc. 
	
	
	corner_counter_1:
		addi s3, s3, 1 # counter for corner fields, taken by player 1
		beq a4, t3, corner_counter_2 # is field 3 taken by player 1?
		beq a4, a1, corner_counter_3 # is field 7 taken by player 1?
		beq a4, a3, corner_counter_4 # is field 9 taken by player 1?
		la s4, bot_rule_3
		jalr zero, 40(s4)
	
	corner_counter_2:
		addi s3, s3, 1 # counter for corner fields, taken by player 1
		beq a4, t3, corner_counter_3 # is field 7 taken by player 1?
		beq a4, a1, corner_counter_4 # is field 9 taken by player 1?
		la s4, bot_rule_3
		jalr zero, 40(s4)
	
	corner_counter_3:
		addi s3, s3, 1 # counter for corner fields, taken by player 1
		beq a3, t3, corner_counter_4 # is field 9 taken by player 1?
		la s4, bot_rule_3
		jalr zero, 40(s4)
	
	corner_counter_4:
		addi s3, s3, 1 # counter for corner fields, taken by player 1
		la s4, bot_rule_3
		jalr zero, 40(s4)


	 bot_rule_3_1: #is field 5 taken by the bot?
	 	li a4, 2
	 	bne a4, t5, bot_rule_4
	 	
	 	#take field 2, 4, 6 or 8
	 	
	 	li a7, 0xffffff #color of player 2 
		li a4, 0
		beq t2, a4, p2_top_middle # if field 2 is free, the bot should use it
		beq t4, a4, p2_middle_left # if field 4 is free, the bot should use it
		beq t6, a4, p2_middle_right # if field 6 is free, the bot should use it		
		beq a2, a4, p2_bottom_middle # if field 8 is free, the bot should use it
		j bot_rule_4	 	
	

#rule 4: are there free corner? then the bot shloud use one of them
bot_rule_4:
	li a7, 0xffffff #color of player 2 
	li a4, 0
	beq t1, a4, p2_top_left # if field 1 is free, the bot should use it
	beq t3, a4, p2_top_right # if field 3 is free, the bot should use it
	beq a1, a4, p2_bottom_left # if field 7 is free, the bot should use it		
	beq a3, a4, p2_bottom_right # if field 9 is free, the bot should use it
	j bot_rule_5 # if no field is free, jump to rule 5
	

#rule 5: the bot should use field 2, 4, 6 or 8
bot_rule_5:
	li a7, 0xffffff #color of player 2 
	li a4, 0
	beq t2, a4, p2_top_middle # if field 2 is free, the bot should use it
	beq t4, a4, p2_middle_left # if field 4 is free, the bot should use it
	beq t6, a4, p2_middle_right # if field 6 is free, the bot should use it		
	beq a2, a4, p2_bottom_middle # if field 8 is free, the bot should use it
	
field_1_r1:
	li a4, 1
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 2
	sw a4, -100(sp) #store the test field
	j win_query	
field_2_r1:
	li a4, 2
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 2
	sw a4, -104(sp) #store the test field
	j win_query		
field_3_r1:
	li a4, 3
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 2
	sw a4, -108(sp) #store the test field
	j win_query		
field_4_r1:
	li a4, 4
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 2
	sw a4, -112(sp) #store the test field
	j win_query		
field_5_r1:
	li a4, 5
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 2
	sw a4, -116(sp) #store the test field
	j win_query		
field_6_r1:
	li a4, 6
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 2
	sw a4, -120(sp) #store the test field
	j win_query
field_7_r1:
	li a4, 7
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 2
	sw a4, -124(sp) #store the test field
	j win_query	
field_8_r1:
	li a4, 8
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 2
	sw a4, -128(sp) #store the test field
	j win_query	
field_9_r1:
	li a4, 9
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 2
	sw a4, -132(sp) #store the test field
	j win_query
	
	
	
	
field_1_r2:
	li a4, 1
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	sw a4, -100(sp) #store the test field
	j win_query	
field_2_r2:
	li a4, 2
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 1
	sw a4, -104(sp) #store the test field
	j win_query		
field_3_r2:
	li a4, 3
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 1
	sw a4, -108(sp) #store the test field
	j win_query		
field_4_r2:
	li a4, 4
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 1
	sw a4, -112(sp) #store the test field
	j win_query		
field_5_r2:
	li a4, 5
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 1
	sw a4, -116(sp) #store the test field
	j win_query		
field_6_r2:
	li a4, 6
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 1
	sw a4, -120(sp) #store the test field
	j win_query
field_7_r2:
	li a4, 7
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 1
	sw a4, -124(sp) #store the test field
	j win_query	
field_8_r2:
	li a4, 8
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 1
	sw a4, -128(sp) #store the test field
	j win_query	
field_9_r2:
	li a4, 9
	sw a4, -240(sp) #save the test field number
	lw a4, -244(sp) #load the correct player number for the field information
	li a4, 1
	sw a4, -132(sp) #store the test field
	j win_query
	
	
#the test field must get resetted
reset_field_1:
	li a0, 0
	sw a0, -100(sp)
	j increase_testfield_counter
reset_field_2:
	li a0, 0
	sw a0, -104(sp)
	j increase_testfield_counter	
reset_field_3:
	li a0, 0
	sw a0, -108(sp)
	j increase_testfield_counter	
reset_field_4:
	li a0, 0
	sw a0, -112(sp)
	j increase_testfield_counter	
reset_field_5:
	li a0, 0
	sw a0, -116(sp)
	j increase_testfield_counter	
reset_field_6:
	li a0, 0
	sw a0, -120(sp)
	j increase_testfield_counter	
reset_field_7:
	li a0, 0
	sw a0, -124(sp)
	j increase_testfield_counter	
reset_field_8:
	li a0, 0
	sw a0, -128(sp)
	j increase_testfield_counter	
reset_field_9:
	li a0, 0
	sw a0, -132(sp)
	lw a3, -132(sp) # for the correct value in a3
	j increase_testfield_counter		




.include "draw_gamefield.asm"	
.include "draw_players.asm"




