# TicTacToe

The programm "TicTacToe" is a computer game in RISC-V-Assembly language.<br>
The user interface is a gamfield, which exists of 9 fields. To win the game, one player must own 3 fiels in a row, a collumn or a diagonal. <br>


## Authors

Name: Timon Trautwein <br>
Email: timon.trautwein@gmx.de

## Demo Video

[![IMAGE ALT TEXT](http://img.youtube.com/vi/-h3eH4ubuno/0.jpg)](http://www.youtube.com/watch?v=-h3eH4ubuno "Video Title")

Replace -h3eH4ubuno in the this .md by your YT video

## Description

The programm "TicTacToe" is a computer game in RISC-V-Assembly language.<br>
The game can be played by one player (human against a bot) or two players (human against human). <br>
Both players can occupy on field per round. It is not allowed to occupy a field, which is already used. To win, one player must own three fields in a row, a collumn or a diagonal.<br>
For the interaction with the programm, you can use the keyboard and the console of "Rars". The gamfield is displayed with the bitmap display function of "Rars"



### How to run

To run the application "tictactoe.asm", you have to use rars with the bitmap display and the console

## Files
1. tictactoe.asm:
    - this file includes all important logic functions of the game, including the multiplayer function and the bot
2. draw_gamefield.asm:
    - function draw_gamefield: this function can draw the gamefield on the bitmap dislpay
    - function draw_numbers: this function can draw the number for each field on the bitmap dislpay
    - function draw_pixel1: this function can draw a pixel on the bitmap dislpay
3. draw_circle.asm:
    - this file can draw a circle (symbol of player 1)
draw_cross.asm:
    - this file can draw a cross (symbol of player 2)
     <br> 
4. unittest_draw_gamefield:
    - unittest for the functions draw_gamefield and draw_cross
5. unittest_win_query:
    - unittest for the functions win_query, bot_or_not_2, player_2_winner and end_menu
6. unittest_draw_cross:
    - unittest for the function draw_cross
7. unittest_draw_circle.asm:
    - unittest for the function draw_circle
     
     
src/tictactoe.asm   # Main file of program

src/draw_gamefield.asm # The functions "draw_gamefield", "draw_numbers" and "draw_pixel1", which are called from the "tictactoe.asm" file

test/draw_circle.asm  # 9 unit tests for featureA


## Test
Screenshot that shows succedded (unit) tests 



