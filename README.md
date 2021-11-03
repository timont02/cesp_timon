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

The programm has a simple structure. After some functions for the start of the game, e.g. drawing the gamefield etc., the programm sequence will always be the same. After the first input of player 1, the input needs to be chacked by two rule functions. This functions proof, that the input number is matching with on of the possible play moves, which the player can carry out. After that, the symbol of the player can be drawn on the gamefield. For this, there is a function with the right coordinates etc. for every field and player. Out of this functions, the functions "draw_cross" and "draw_circle" are getting called. Technically, they are responsible for the actual drawing in the bitmap display. After that, the game checks, if there is a winner. For that, tha game compares every row, collumn and diagonal on three fields with the same player. After that, that next player can make a move. <br>
If there is a human playing against a bot, the programm sequence will be the same, except that the input option for player 2 (function "player_2_loop") gets skipped and replaced by the bot funciton. The bot works after some strict rules. To sum up the rules, the bot must look out if he can win. if he can win, he must take the appropriate field. If he cant win, he must look out if the other player can win. If this is the case, the bot must block him. If this isn't the case too, there are some more strict rules. A more accurate version of the rules can be find here: https://www.geniale-tipps.de/hobby/spiele/tic-tac-toe-gewinnstrategie.html . On this page, the matching rules for the bot are the rules for player 2.
Note: If the human player makes a mistake, the bot will win the game (or equalize). If the human player plays a perfect match (according to the given rules on the internet page above) the bot has no chance of winning. This is not the responsible of the bot. The function of TicTacToe are responsible for this.


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

###Unittest draw_cross




![unittest_draw_cross](https://user-images.githubusercontent.com/83597101/140091173-39c16860-763f-4c1e-82c5-ffcc68639456.png)

###Unittest draw_gamefield

![unittest_draw_gamefield](https://user-images.githubusercontent.com/83597101/140091176-e3e4edd0-d17d-4ea7-aa8e-290d7b9337d4.png)

###Unittest win_query

![unittest_win_query](https://user-images.githubusercontent.com/83597101/140091179-6f367266-e3d1-4130-9bf6-10934abe64cc.png)

###Unittest bot_rule_1

![unittest_bot_rule_1](https://user-images.githubusercontent.com/83597101/140091182-a490cccb-fe26-4366-868a-9250db290770.png)

###Unittest draw_circle

![unittest_draw_circle](https://user-images.githubusercontent.com/83597101/140091185-5f6f52c9-d18b-4f1a-a60d-3b503caa29a1.png)
