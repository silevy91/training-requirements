import numpy as np
import pandas as pd
import random
import time


def add_symbol(board, row, column, symbol):
    board.at[row, column] = symbol


def check_for_winner(board, symbol):
    board_check = pd.DataFrame(board == symbol)
    if board_check.all(axis='columns').any():
        print(symbol + " wins!")
        quit()

    if board_check.all(axis='index').any():
        print(symbol + " wins!")
        quit()

    if np.diag(board_check).all():
        print(symbol + " wins!")
        quit()

    if np.diag(np.fliplr(board_check)).all():
        print(symbol + " wins!")
        quit()

    if not available_fields:
        print("Tie!")
        quit()

    return


def player_move():
    while True:
        input_row = input("Row? ")
        if input_row == "quit":
            quit()
        elif input_row == "0" or input_row == "1" or input_row == "2":
            input_row = int(input_row)
        else:
            print("Invalid entry. Only enter 0, 1, 2, or quit")
            continue

        input_column = input("Column? ")
        if input_column == "quit":
            quit()
        elif input_column == "0" or input_column == "1" or input_column == "2":
            input_column = int(input_column)
        else:
            print("Invalid entry. Only enter 0, 1, 2, or quit")
            continue

        if (input_row, input_column) in available_fields:
            available_fields.remove((input_row, input_column))
            add_symbol(current_board, input_row, input_column, user_symbol)
            break
        else:
            print("Sorry, this field has already been used. Try again!")
            continue
    return


def pc_move():
    current_field = available_fields.pop(random.randint(0, len(available_fields) - 1))
    add_symbol(current_board, current_field[0], current_field[1], pc_symbol)
    return


user_symbol = None
pc_symbol = None
available_fields = [(0, 0), (0, 1), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 1), (2, 2)]
current_board = pd.DataFrame({0: [".", ".", "."], 1: [".", ".", "."], 2: [".", ".", "."], })

while True:
    user_symbol = input("X or O? Type 'quit' at any prompt to exit. ")

    if user_symbol == "quit":
        quit()
    elif user_symbol == "X" or user_symbol == "x":
        user_symbol = "X"
        pc_symbol = "O"
        break
    elif user_symbol == "O" or user_symbol == "o":
        user_symbol = "O"
        pc_symbol = "X"
        break
    else:
        print("Invalid entry. Only enter X, O, or quit.")
        continue

for current_round in range(9):
    print("########################\n#####   ROUND #" + str(current_round + 1) + "   #####\n########################")
    time.sleep(2)
    if user_symbol == "X":
        # Player move
        print("CURRENT BOARD:\n------------------------")
        print(current_board)
        print("------------------------\n")
        print("Player X move:")
        player_move()
        print("CURRENT BOARD:\n------------------------")
        print(current_board)
        print("------------------------\n")
        time.sleep(2)
        check_for_winner(current_board, user_symbol)

        # PC move
        print("Player O move:")
        time.sleep(1)
        pc_move()
        print("Computer move registered.")
        time.sleep(2)
        print("CURRENT BOARD:\n------------------------")
        print(current_board)
        print("------------------------\n")
        time.sleep(2)
        check_for_winner(current_board, pc_symbol)
    else:
        # PC move
        print("CURRENT BOARD:\n------------------------")
        print(current_board)
        print("------------------------\n")
        print("Player X move:")
        time.sleep(1)
        pc_move()
        print("Computer move registered.")
        time.sleep(2)
        print("CURRENT BOARD:\n------------------------")
        print(current_board)
        print("------------------------\n")
        time.sleep(2)
        check_for_winner(current_board, pc_symbol)

        # Player move
        print("Player O move:")
        player_move()
        print("CURRENT BOARD:\n------------------------")
        print(current_board)
        print("------------------------\n")
        time.sleep(2)
        check_for_winner(current_board, user_symbol)
