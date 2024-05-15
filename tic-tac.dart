import 'dart:io';

void main() {
  List<String> board = List.filled(9, ' ');
  int currentPlayer = 0; // 0 for player X, 1 for player O
  bool gameWon = false;

  print("Welcome to Tic-Tac-Toe!");

  // Game loop
  while (!gameWon && board.contains(' ')) {
    printBoard(board);

    // Get current player's move
    int move;
    while (true) {
      stdout.write(
          "Player ${currentPlayer == 0 ? 'X' : 'O'}, enter your move (1-9): ");
      String input = stdin.readLineSync() ?? '';
      if (input.isEmpty) {
        continue;
      }
      move = int.tryParse(input) ?? 0;
      if (move >= 1 && move <= 9 && board[move - 1] == ' ') {
        break;
      } else {
        print("Invalid move. Please try again.");
      }
    }

    // Make the move
    board[move - 1] = currentPlayer == 0 ? 'X' : 'O';

    // Check if the game has been won
    gameWon = checkWin(board, currentPlayer == 0 ? 'X' : 'O');

    // Switch players
    currentPlayer = (currentPlayer + 1) % 2;
  }

  printBoard(board);

  // Print game result
  if (gameWon) {
    print("Player ${currentPlayer == 0 ? 'X' : 'O'} wins!");
  } else {
    print("It's a draw!");
  }
}

void printBoard(List<String> board) {
  print('');
  for (int i = 0; i < 3; i++) {
    print(' ${board[i * 3]} | ${board[i * 3 + 1]} | ${board[i * 3 + 2]} ');
    if (i < 2) print('-----------');
  }
  print('');
}

bool checkWin(List<String> board, String player) {
  // Check rows, columns, and diagonals
  for (int i = 0; i < 3; i++) {
    if ((board[i * 3] == player &&
            board[i * 3 + 1] == player &&
            board[i * 3 + 2] == player) ||
        (board[i] == player &&
            board[i + 3] == player &&
            board[i + 6] == player)) {
      return true;
    }
  }
  if ((board[0] == player && board[4] == player && board[8] == player) ||
      (board[2] == player && board[4] == player && board[6] == player)) {
    return true;
  }
  return false;
}
