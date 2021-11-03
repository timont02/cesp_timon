# Programming Project TicTacToe

The programm "TicTacToe" is a computer game in RISC-V-Assembly language.<br>
The user interface is a gamfield, which exists of 9 fields. To win the game, one player must own three fiels in a row, a column or a diagonal. <br>


## Authors

Name: Timon Trautwein <br>
Email: timon.trautwein@gmx.de

## Demo Video

[![IMAGE ALT TEXT](http://img.youtube.com/vi/-h3eH4ubuno/0.jpg)](http://www.youtube.com/watch?v=-h3eH4ubuno "Video Title")

Replace -h3eH4ubuno in the this .md by your YT video

## Description

The programm "TicTacToe" is a computer game in RISC-V-Assembly language. It was coded completely in assembly language.<br>
To run the programm, the user needs "Rars". For the interaction with the programm, you can use the keyboard and the console of "Rars". The gamfield is displayed with the bitmap display function of "Rars". Text messages, like the menu and the current player are dislpayed at the console of "Rars". <br>
The game can be played by one player (human against computer) or two players (human against human). <br>
Both players can occupy on field per round. They take turns playing. It is not allowed to occupy a field, which is already used. To win, one player must own three fields in a row, a column or a diagonal.<br>
To occupy a field, the current player must enter the number of the field, which he wants to occupy, in the console. If there is an error with the input (e.g. input number is not between 1 and 9), there will be an error message with further instructiosn for the player. Everytime, the player must enter something in the console, there will we a text message with instructions for the input in the console.

The programm has a simple structure. 





### How to run

To use the application, you have run the "tictactoe.asm" in rars with the bitmap display and the console.

## Files

src/tictactoe.asm   # this file includes all important logic functions of the game, including the multiplayer function and the bot

src/draw_gamefield.asm # this field includes the functions for drawing the gamefield and the numbers for each field

src/draw_players.asm # thie file includes the functions for drawing a circle (player 1) and a cross (player 2)

test/unittest_draw_gamefield.asm  # unittest for the function draw_gamefield

test/unittest_win_query.asm  # unittest for the function win_query

test/unittest_draw_cross.asm  # unittest for the function draw_cross

test/unittest_draw_circle.asm  # unittest for the function draw_circle

test/unittest_bot_rule_1.asm  # unittest for the function bot_rule_1



## Test




