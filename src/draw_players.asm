
#this function can draw a circle for player 1.

# a3: x coordinate
# a4: y coordinate
# a5: radius in pixels
# a7: color

draw_circle:

#store all used registers
li t6, 0 ###################################################################
addi sp, sp, -372
sw a0, 4(sp)
sw a1, 8(sp)
sw a3, 12(sp)
sw a4, 16(sp)
sw a5, 20(sp)
sw a7, 24(sp)
sw ra, 28(sp)
sw s1, 32(sp) 
sw s2, 36(sp)
sw s3, 40(sp)
sw t0, 44(sp)
sw t3, 48(sp)
sw t4, 52(sp)
sw t6, 56(sp)


li t6, 0
li a0, 1
li a1, 5 # line width

loop_line_width:
lw a3, 12(sp)
lw a4, 16(sp)
mv s1, a5 # x = r
li s2, 0 # y = 0
sub s3, zero, a5 # d = -r

_loop0:
	slli t0, s2, 2
	addi t0, t0, 1
	add s3, s3, t0 # d = d + 2*y + 1
	addi s2, s2, 1 # y = y + 1
	ble s3, zero, _lesseq	
		slli t0, s1, 2
		sub s3, s3, t0 
		addi s3, s3, 2 # d = d - 2*x + 2
		addi s1, s1, -1
	_lesseq:		

	lw a3, 12(sp)
	lw a4, 16(sp)
	lw a5, 20(sp)
	lw a7, 24(sp)
	
	add a3, a3, s1 # xc + x
	add a4, a4, s2 # yc + y
	jal draw_pixel

	lw a3, 12(sp)
	lw a4, 16(sp)
	lw a5, 20(sp)
	lw a7, 24(sp)

	sub a3, a3, s1 # xc - x
	add a4, a4, s2 # yc + y
	jal draw_pixel

	lw a3, 12(sp)
	lw a4, 16(sp)
	lw a5, 20(sp)
	lw a7, 24(sp)

	add a3, a3, s1 # xc + x
	sub a4, a4, s2 # yc - y
	jal draw_pixel

	lw a3, 12(sp)
	lw a4, 16(sp)
	lw a5, 20(sp)
	lw a7, 24(sp)
	
	sub a3, a3, s1 # xc - x
	sub a4, a4, s2 # yc - y
	jal draw_pixel
	
	lw a3, 12(sp)
	lw a4, 16(sp)
	lw a5, 20(sp)
	lw a7, 24(sp)

	add a3, a3, s2 # xc + y
	add a4, a4, s1 # yc + x
	jal draw_pixel

	lw a3, 12(sp)
	lw a4, 16(sp)
	lw a5, 20(sp)
	lw a7, 24(sp)
	
	sub a3, a3, s2 # xc - y
	add a4, a4, s1 # yc + x
	jal draw_pixel

	lw a3, 12(sp)
	lw a4, 16(sp)
	lw a5, 20(sp)
	lw a7, 24(sp)
	
	
	add a3, a3, s2 # xc + y
	sub a4, a4, s1 # yc - x
	jal draw_pixel

	lw a3, 12(sp)
	lw a4, 16(sp)
	lw a5, 20(sp)
	lw a7, 24(sp)
	
	sub a3, a3, s2 # xc - y
	sub a4, a4, s1 # yc - x
	jal draw_pixel

# to draw a circle width a line width of 5
_end_loop:
	ble s2, s1 _loop0
	addi a0, a0, 1
	beq a0, a1, exit_draw_circle
	lw a5, 20(sp)
	addi a5, a5, 1
	sw a5, 20(sp)
	j loop_line_width
	
# Restore the callee-save reisters
exit_draw_circle:
lw a0, 4(sp)
lw a1, 8(sp)
lw a3, 12(sp)
lw a4, 16(sp)
lw a5, 20(sp)
lw a7, 24(sp)
lw ra, 28(sp)
lw s1, 32(sp) 
lw s2, 36(sp)
lw s3, 40(sp)
lw t0, 44(sp)
lw t3, 48(sp)
lw t4, 52(sp)
lw t6, 56(sp)

addi sp, sp, 372

ret


draw_pixel: # Creates colored pixel at position (x,y)  

	# Calculate address
	li t3, DISPLAY_ADDRESS
	li t4, DISPLAY_WIDTH
	mul t6, a4, t4
	add t6, t6, a3
	slli, t6, t6, 2 # address *4
	add t6, t6, t3
	
	sw a7, (t6)
	ret
	
	
	
	
	

#this functions can draw a cross for player 2.

draw_cross:
#save the used registers
	sw t1, -252(sp)
	sw t2, -256(sp)
	sw t3, -260(sp)
	sw t4, -264(sp)
	sw t5, -268(sp)
	sw t6, -272(sp)
	sw a1, -276(sp)
	sw a2, -280(sp)
	sw a3, -284(sp)
	sw a4, -288(sp)
	sw a6, -292(sp)
	sw a7, -296(sp)
	sw ra, -228(sp)

#move x, y and color to the right register
mv a1, a3
mv a2, a4
mv a3, a7


#save the point
mv t0, a1
mv t1, a2

#calculate the end of the first bar
addi t2, a1, 40
addi t3, a2, 40
#calculate the start of the first bar
addi a1, a1, -40
addi a2, a2, -40


#save the begin	of the cross
mv t4, a1
mv t5, a2

li a6, 0 #variable for width
li t6, 4 #width of the bar

	#draw the first part of the cros (the bar from top left to bottom right)
	cross_loop_1_1:
		
		cross_loop_1_2: #draw a line with the width of one pixel
		
			jal draw_pixel1 
			addi a1, a1, 1
			addi a2, a2, 1
			bne t3, a2, cross_loop_1_2
	addi t4, t4, 1 #draw the line one pixel to the right
	mv a1, t4
	mv a2, t5
	addi a6, a6, 1
	bne t6, a6, cross_loop_1_1

	#load the point
	mv a1, t0
	mv a2, t1
	#calculate the end of the first bar
	addi t2, a1, 40
	addi t3, a2, -40
	#calculate the start of the first bar
	addi a1, a1, -40
	addi a2, a2, 40

	#save the begin		
	mv t4, a1
	mv t5, a2
	
	li a6, 0 #variable for width
	li t6, 4 #width of the bar

	#draw the second part of the cros (the bar from bottom left to top right)
	cross_loop_2_1:
		
		cross_loop_2_2: #draw a line with the width of one pixel
		
			jal draw_pixel1
			addi a1, a1, 1
			addi a2, a2, -1
			bne t3, a2, cross_loop_2_2
	addi t4, t4, 1 #draw the line one pixel to the right
	mv a1, t4
	mv a2, t5
	addi a6, a6, 1
	bne t6, a6, cross_loop_2_1
	
#restore the used registers
	lw t1, -252(sp)
	lw t2, -256(sp)
	lw t3, -260(sp)
	lw t4, -264(sp)
	lw t5, -268(sp)
	lw t6, -272(sp)
	lw a1, -276(sp)
	lw a2, -280(sp)
	lw a3, -284(sp)
	lw a4, -288(sp)
	lw a6, -292(sp)
	lw a7, -296(sp)
	lw ra, -228(sp)	 #return to the main programm
	ret


