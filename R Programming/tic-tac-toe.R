# Function definitions
player_move <- function(){
  while(TRUE) {
    cat("Row? ")
    input_row <-  readLines(con = con, n = 1)
    if(input_row == "quit") {
      quit()
    } else if(input_row == "1" | input_row == "2" | input_row == "3") {
      input_row <- as.numeric(input_row)
    } else {
      cat("Invalid input. Please only enter 1, 2, 3, or quit \n")
      next
    }
      
    cat("Column? ")
    input_column = readLines(con = con, n = 1)
    if(input_column == "quit") {
      quit()
    } else if(input_column == "1" | input_column == "2" | input_column == "3") {
      input_column <- as.numeric(input_column)
    } else {
      cat("Invalid input. Please only enter 1, 2, 3, or quit \n")
      next
    }
    
    if(any(sapply(available_fields, function(x) {all(x == c(input_row, input_column))}))) {
      available_fields[which(sapply(available_fields, function(x) {all(x == c(input_row, input_column))}))] <<- NULL
      current_board[input_row, input_column] <<- user_symbol
      break
    } else {
      cat("This field has already been filled. Please select an empty field. \n")
      next
    }
  }
}

pc_move <- function(){
  current_index <- sample.int(length(available_fields), 1)
  current_field <- available_fields[[current_index]]
  available_fields[[current_index]] <<- NULL
  current_board[current_field[1], current_field[2]] <<- pc_symbol
}

check_for_winner <- function(symbol){
  row_win = any(apply(current_board, 1, function(x) {isTRUE(all.equal(x, c(symbol, symbol, symbol)))}))
  column_win = any(apply(current_board, 2, function(x) {isTRUE(all.equal(x, c(symbol, symbol, symbol)))}))
  diagonal_win = isTRUE(all.equal(diag(current_board), c(symbol, symbol, symbol)))
  antidiagonal_win = isTRUE(all.equal(diag(current_board[nrow(current_board):1, ]), c(symbol, symbol, symbol)))
  
  if(row_win | column_win | diagonal_win | antidiagonal_win) {
    cat(paste0(symbol, " wins!"))
    quit()
  }
  if(length(available_fields) == 0) {
    cat("Tie!")
    quit()
  }
}

# Initialize script parameters
if (interactive()) {
  con <- stdin()
} else {
  con <- "stdin"
}

# Initialize game variables
user_symbol <-  NULL
pc_symbol <-  NULL
current_board <-  matrix(rep(NA, times = 9), nrow = 3, ncol = 3)
available_fields <-  list(c(1,1), c(1,2), c(1,3), c(2,1), c(2,2), c(2,3), c(3,1), c(3,2), c(3,3))


# Initial game setup
while(TRUE) {
  cat("X or O? ")
  user_symbol <- readLines(con = con, n = 1)
  
  if(user_symbol == "quit") {
    quit()
  } else if(user_symbol == "X" | user_symbol == "x") {
    user_symbol <- "X"
    pc_symbol <- "O"
    break
  } else if(user_symbol == "O" | user_symbol == "o") {
    user_symbol <- "O"
    pc_symbol <- "X"
    break
  } else {
    cat("Invalid entry. Please only enter X, O, or quit \n")
    next
  }
}

#Game
for (current_round in 1:9) {
  cat(paste0("################# Round ", current_round, ": #################\n"))
  Sys.sleep(1)
  cat("Current board:\n")
  print(current_board)
  cat("\n\n")
  if(user_symbol == "X"){
    # Player move
    cat("Player X move\n")
    Sys.sleep(1)
    player_move()
    Sys.sleep(1)
    cat("Current board:\n")
    print(current_board)
    cat("\n\n")
    check_for_winner(user_symbol)
    Sys.sleep(1)
    
    # PC move
    cat("Player O move\n")
    Sys.sleep(1)
    cat("Executing computer move...\n")
    pc_move()
    Sys.sleep(1)
    cat("Current board:\n")
    print(current_board)
    cat("\n\n")
    check_for_winner(pc_symbol)
    Sys.sleep(1)
  } else {
    # PC move
    cat("Player X move\n")
    Sys.sleep(1)
    cat("Executing computer move...\n")
    pc_move()
    Sys.sleep(1)
    cat("Current board:\n")
    print(current_board)
    cat("\n\n")
    check_for_winner(pc_symbol)
    Sys.sleep(1)
    
    # Player move
    cat("Player O move\n")
    Sys.sleep(1)
    player_move()
    Sys.sleep(1)
    cat("Current board:\n")
    print(current_board)
    cat("\n\n")
    check_for_winner(user_symbol)
    Sys.sleep(1)
  }
}