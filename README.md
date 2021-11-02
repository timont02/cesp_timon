# TicTacToe

The programm "TicTacToe" is a computer game in RISC-V-Assembly language.<br>
The game can be played by one player (human against a bot) or two players (human against human). <br>
Both players can occupy on field per round. It is not allowed to occupy a field, which is already used. To win, one player must own three fields in a row, a collumn or a diagonal.<br>
For the interaction with the programm, you can use the keyboard and the console of "Rars". The gamfield is displayed with the bitmap display function of "Rars"

## Authors

Name: Timon Trautwein <br>
Email: timon.trautwein@gmx.de

## Demo Video

[![IMAGE ALT TEXT](http://img.youtube.com/vi/-h3eH4ubuno/0.jpg)](http://www.youtube.com/watch?v=-h3eH4ubuno "Video Title")

Replace -h3eH4ubuno in the this .md by your YT video

## Description

An in-depth paragraph about your project and overview of use.



### How to run

To run the application "tictactoe.asm", you have to use rars with the bitmap display and the console

## Files
tictactoe.asm:<br>
    - this file includes all important logic functions of the game, including the multiplayer function and the bot<br>
draw_gamefield.asm:<br>
      - function draw_gamefield: this function can draw the gamefield on the bitmap dislpay<br>
      - function draw_numbers: this function can draw the number for each field on the bitmap dislpay<br>
      - function draw_pixel1: this function can draw a pixel on the bitmap dislpay<br>
draw_circle.asm:<br>
      - this file can draw a circle (symbol of player 1)<br>
draw_cross.asm:<br>
      - this file can draw a cross (symbol of player 2)<br>
      <br>
unittest_draw_gamefield:<br>
      - unittest for the functions draw_gamefield and draw_cross<br>
unittest_win_query:<br>
      - unittest for the functions win_query, bot_or_not_2, player_2_winner and end_menu<br>
unittest_draw_cross:<br>
      - unittest for the function draw_cross<br>
unittest_draw_circle:<br>
      - unittest for the function draw_circle<br>
     
     
src/main.c   # Main file of program

src/main.asm # compiled version of main.c for RV32IM

src/featureA.asm # A specific feature called in main

test/test1.asm - test9.asm # 9 unit tests for featureA


## Test
Screenshot that shows succedded (unit) tests 


1. tictactoe.asm:
    - this file includes all important logic functions of the game, including the multiplayer function and the bot
2. draw_gamefield.asm:
	1. function draw_gamefield: this function can draw the gamefield on the bitmap dislpay
	2. function draw_numbers: this function can draw the number for each field on the bitmap dislpay
	3. function draw_pixel1: this function can draw a pixel on the bitmap dislpay
3. Genießen

