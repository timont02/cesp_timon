
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
