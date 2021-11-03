
#this function can draw the gamefield and the number for each field.

draw_gamefield:
	
	#only the return address needs to be stored, because this functions is only used once at the beginning of the programm, where no registers are used
	sw ra, -204(sp)
	
	li a3,  0xFFFFFF # color white

	
	#different instructions for the loop. 
	#first collumn
	li t3, 1 #x start
	li a4, 512 # x end
	li t1, 166 # y begin
	li a5, 174 # y end
	jal ra, draw_lines
	#second collumn
	li t3, 1 #x start
	li a4, 512 # x end
	li t1, 336 # y begin
	li a5, 344 # y end 
	jal ra, draw_lines
	
	#first row
	li t3, 166 #x start
	li a4, 174 # x end
	li t1, 1 # y begin
	li a5, 512 # y end
	jal ra, draw_lines
	#second row
	li t3, 336 #x start
	li a4, 344 # x end
	li t1, 1 # y begin
	li a5, 512 # y end
	jal ra, draw_lines
	
	jal ra, draw_numbers #now the numbers are drawn 
	
	lw ra, -204(sp)
	ret
	
draw_lines:
	sw ra, -200(sp) #save the return address
	mv t0, t3
		loopy: 
			loopx: #a line of one pixel gets drawn in x-direction
	              		mv a1, t0
				mv a2, t1
				jal draw_pixel1
				addi t0, t0, 1
				bne t0, a4, loopx
		addi t1, t1, 1 #next line in y-direction
		mv t0, t3
		bne t1, a5, loopy
		lw ra, -200(sp) #reload the return address
		ret
		
draw_numbers:
	#one number for every field. This functions just calls the draw_lines functions with the right input parameters for every line of the number
	#number 1
	li t3, 155 #x start
	li a4, 160 # x end
	li t1, 140 # y begin
	li a5, 162 # y end
	jal ra, draw_lines
	
	#number 2
	li t3, 328 #x start
	li a4, 332 # x end
	li t1, 140 # y begin
	li a5, 151 # y end
	jal ra, draw_lines
	li t3, 317 #x start
	li a4, 321 # x end
	li t1, 151 # y begin
	li a5, 162 # y end
	jal ra, draw_lines
	li t3, 317 #x start
	li a4, 332 # x end
	li t1, 139 # y begin
	li a5, 143 # y end
	jal ra, draw_lines
	li t3, 317 #x start
	li a4, 332 # x end
	li t1, 149 # y begin
	li a5, 153 # y end
	jal ra, draw_lines
	li t3, 317 #x start
	li a4, 332 # x end
	li t1, 158 # y begin
	li a5, 162 # y end
	jal ra, draw_lines
	
	#number 3
	li t3, 494 #x start
	li a4, 509 # x end
	li t1, 139 # y begin
	li a5, 143 # y end
	jal ra, draw_lines
	li t3, 494 #x start
	li a4, 509 # x end
	li t1, 149 # y begin
	li a5, 153 # y end
	jal ra, draw_lines
	li t3, 494 #x start
	li a4, 509 # x end
	li t1, 158 # y begin
	li a5, 162 # y end
	jal ra, draw_lines
	li t3, 317 #x start
	li a4, 332 # x end
	li t1, 149 # y begin
	li a5, 153 # y end
	jal ra, draw_lines
	li t3, 505 #x start
	li a4, 509 # x end
	li t1, 140 # y begin
	li a5, 162 # y end
	jal ra, draw_lines
	
	#number 4		
	li t3, 155 #x start
	li a4, 160 # x end
	li t1, 311 # y begin
	li a5, 333 # y end
	jal ra, draw_lines
	li t3, 145 #x start
	li a4, 160 # x end
	li t1, 320 # y begin
	li a5, 324 # y end
	jal ra, draw_lines
	li t3, 145 #x start
	li a4, 149 # x end
	li t1, 311 # y begin
	li a5, 324 # y end
	jal ra, draw_lines
	
	#number 5
	li t3, 317 #x start
	li a4, 321 # x end
	li t1, 311 # y begin
	li a5, 324 # y end
	jal ra, draw_lines
	li t3, 317 #x start
	li a4, 332 # x end
	li t1, 320 # y begin
	li a5, 324 # y end
	jal ra, draw_lines
	li t3, 328 #x start
	li a4, 332 # x end
	li t1, 320 # y begin
	li a5, 333 # y end
	jal ra, draw_lines
	li t3, 317 #x start
	li a4, 332 # x end
	li t1, 311 # y begin
	li a5, 315 # y end
	jal ra, draw_lines
	li t3, 317 #x start
	li a4, 332 # x end
	li t1, 329 # y begin
	li a5, 333 # y end
	jal ra, draw_lines
	
	#number 6
	li t3, 494 #x start
	li a4, 509 # x end
	li t1, 311 # y begin
	li a5, 315 # y end
	jal ra, draw_lines
	li t3, 494 #x start
	li a4, 509 # x end
	li t1, 320 # y begin
	li a5, 324 # y end
	jal ra, draw_lines
	li t3, 494 #x start
	li a4, 509 # x end
	li t1, 329 # y begin
	li a5, 333 # y end
	jal ra, draw_lines
	li t3, 494 #x start
	li a4, 497 # x end
	li t1, 311 # y begin
	li a5, 333 # y end
	jal ra, draw_lines
	li t3, 505 #x start
	li a4, 509 # x end
	li t1, 324 # y begin
	li a5, 333 # y end
	jal ra, draw_lines
	
	#number 7
	li t3, 155 #x start
	li a4, 160 # x end
	li t1, 487 # y begin
	li a5, 509 # y end
	jal ra, draw_lines
	li t3, 145 #x start
	li a4, 160 # x end
	li t1, 487 # y begin
	li a5, 491 # y end
	jal ra, draw_lines
	
	#number 8
	li t3, 317 #x start
	li a4, 321 # x end
	li t1, 487 # y begin
	li a5, 509 # y end
	jal ra, draw_lines
	li t3, 317 #x start
	li a4, 332 # x end
	li t1, 487 # y begin
	li a5, 491 # y end
	jal ra, draw_lines
	li t3, 328 #x start
	li a4, 332 # x end
	li t1, 487 # y begin
	li a5, 509 # y end
	jal ra, draw_lines
	li t3, 317 #x start
	li a4, 332 # x end
	li t1, 505 # y begin
	li a5, 509 # y end
	jal ra, draw_lines
	li t3, 317 #x start
	li a4, 332 # x end
	li t1, 496 # y begin
	li a5, 500 # y end
	jal ra, draw_lines
	lw ra, -204(sp)
	
	#number 9
	li t3, 504 #x start
	li a4, 509 # x end
	li t1, 487 # y begin
	li a5, 509 # y end
	jal ra, draw_lines
	li t3, 496 #x start
	li a4, 509 # x end
	li t1, 487 # y begin
	li a5, 491 # y end
	jal ra, draw_lines
	li t3, 496 #x start
	li a4, 509 # x end
	li t1, 505 # y begin
	li a5, 509 # y end
	jal ra, draw_lines
	li t3, 496 #x start
	li a4, 509 # x end
	li t1, 496 # y begin
	li a5, 500 # y end
	jal ra, draw_lines
	li t3, 496 #x start
	li a4, 500 # x end
	li t1, 487 # y begin
	li a5, 498 # y end
	jal ra, draw_lines
	
	lw ra, -204(sp) #reload the return address
	ret


	
		
			
#this function can draw a pixel on the display.

#    a1: x
#    a2: y
#    a3: color

draw_pixel1:
	
	#Save the registers
	addi sp, sp, -16
	sw s0, 0 (sp)
	sw s1, 4 (sp)
	sw s2, 8 (sp)
	sw ra, 12(sp)
	
	li s0, DISPLAY_ADDRESS
	li s1, DISPLAY_WIDTH
	
	# y_offset
	mul s2, s1, a2  # y∗DISPLAY_WIDTH
			
	# crt_address = base_address + x_offset + y_offset
	add s2, a1, s2
	slli s2, s2, 2 # *4 to byte address
	
	add s2, s2, s0 

	#Store the value of a3 in the memory at the calculated address.
	# *crt_address = a3
	sw a3, (s2)

	#restore the callee save values
	lw s0, 0 (sp)
	lw s1, 4 (sp)
	sw s2, 8 (sp)
	sw ra, 12(sp)
	addi sp, sp, 16
	ret
	
	
