import 'dart:math';

class Player {
  static const String x = "X";
  static const String o = "O";
  static const String empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

class Game {
  void playGame(int index, String activePlayer) {
    if (activePlayer == "x") {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  String checkWinner() {
    String winner = "";
    if (Player.playerX.containsAll(0, 1, 2) ||
        Player.playerX.containsAll(3, 4, 5) ||
        Player.playerX.containsAll(6, 7, 8) ||
        Player.playerX.containsAll(0, 3, 6) ||
        Player.playerX.containsAll(1, 4, 7) ||
        Player.playerX.containsAll(2, 5, 8) ||
        Player.playerX.containsAll(0, 4, 8) ||
        Player.playerX.containsAll(2, 4, 6)) {
      winner = "x";
    } else if (Player.playerO.containsAll(0, 1, 2) ||
        Player.playerO.containsAll(3, 4, 5) ||
        Player.playerO.containsAll(6, 7, 8) ||
        Player.playerO.containsAll(0, 3, 6) ||
        Player.playerO.containsAll(1, 4, 7) ||
        Player.playerO.containsAll(2, 5, 8) ||
        Player.playerO.containsAll(0, 4, 8) ||
        Player.playerO.containsAll(2, 4, 6)) {
      winner = "o";
    }

    return winner;
  }

  bool getCellToX(int a, int b, int c, List emptyCells) {
    return Player.playerX.containsAll(a, b) && emptyCells.contains(c);
  }

  bool getCellToO(int a, int b, int c, List emptyCells) {
    return Player.playerO.containsAll(a, b) && emptyCells.contains(c);
  }

  void autoPlay(activePlayer) {
    List<int> emptyCells = [];
    int cell = 0;
    for (int i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        emptyCells.add(i);
      }
    }

    if (getCellToO(0, 1, 2, emptyCells))
      cell = 2;
    else if (getCellToO(3, 4, 5, emptyCells))
      cell = 5;
    else if (getCellToO(6, 7, 8, emptyCells))
      cell = 8;
    else if (getCellToO(0, 3, 6, emptyCells))
      cell = 6;
    else if (getCellToO(1, 4, 7, emptyCells))
      cell = 7;
    else if (getCellToO(2, 5, 8, emptyCells))
      cell = 8;
    else if (getCellToO(0, 4, 8, emptyCells))
      cell = 8;
    else if (getCellToO(2, 4, 6, emptyCells))
      cell = 6;

    //  second
    else if (getCellToO(0, 2, 1, emptyCells))
      cell = 1;
    else if (getCellToO(3, 5, 4, emptyCells))
      cell = 4;
    else if (getCellToO(6, 8, 7, emptyCells))
      cell = 7;
    else if (getCellToO(0, 6, 3, emptyCells))
      cell = 3;
    else if (getCellToO(1, 7, 4, emptyCells))
      cell = 4;
    else if (getCellToO(2, 8, 5, emptyCells))
      cell = 5;
    else if (getCellToO(0, 8, 4, emptyCells))
      cell = 4;
    else if (getCellToO(2, 6, 4, emptyCells))
      cell = 4;

    //  third
    else if (getCellToO(2, 1, 0, emptyCells))
      cell = 0;
    else if (getCellToO(5, 4, 3, emptyCells))
      cell = 3;
    else if (getCellToO(8, 7, 6, emptyCells))
      cell = 6;
    else if (getCellToO(6, 3, 0, emptyCells))
      cell = 0;
    else if (getCellToO(7, 4, 1, emptyCells))
      cell = 1;
    else if (getCellToO(8, 5, 2, emptyCells))
      cell = 2;
    else if (getCellToO(8, 4, 0, emptyCells))
      cell = 0;
    else if (getCellToO(6, 4, 2, emptyCells))
      cell = 2;
    //first X
    else if (getCellToX(0, 1, 2, emptyCells))
      cell = 2;
    else if (getCellToX(3, 4, 5, emptyCells))
      cell = 5;
    else if (getCellToX(6, 7, 8, emptyCells))
      cell = 8;
    else if (getCellToX(0, 3, 6, emptyCells))
      cell = 6;
    else if (getCellToX(1, 4, 7, emptyCells))
      cell = 7;
    else if (getCellToX(2, 5, 8, emptyCells))
      cell = 8;
    else if (getCellToX(0, 4, 8, emptyCells))
      cell = 8;
    else if (getCellToX(2, 4, 6, emptyCells))
      cell = 6;

    //  second x
    else if (getCellToX(0, 2, 1, emptyCells))
      cell = 1;
    else if (getCellToX(3, 5, 4, emptyCells))
      cell = 4;
    else if (getCellToX(6, 8, 7, emptyCells))
      cell = 7;
    else if (getCellToX(0, 6, 3, emptyCells))
      cell = 3;
    else if (getCellToX(1, 7, 4, emptyCells))
      cell = 4;
    else if (getCellToX(2, 8, 5, emptyCells))
      cell = 5;
    else if (getCellToX(0, 8, 4, emptyCells))
      cell = 4;
    else if (getCellToX(2, 6, 4, emptyCells))
      cell = 4;

    //  third X
    else if (getCellToX(2, 1, 0, emptyCells))
      cell = 0;
    else if (getCellToX(5, 4, 3, emptyCells))
      cell = 3;
    else if (getCellToX(8, 7, 6, emptyCells))
      cell = 6;
    else if (getCellToX(6, 3, 0, emptyCells))
      cell = 0;
    else if (getCellToX(7, 4, 1, emptyCells))
      cell = 1;
    else if (getCellToX(8, 5, 2, emptyCells))
      cell = 2;
    else if (getCellToX(8, 4, 0, emptyCells))
      cell = 0;
    else if (getCellToX(6, 4, 2, emptyCells))
      cell = 2;
    else {
      Random random = Random();
      int randomIndex = random.nextInt(emptyCells.length);
      cell = emptyCells[randomIndex];
    }
    playGame(cell, activePlayer);
  }
}

extension ContainsAll on List {
  bool containsAll(int a, int b, [int? c]) {
    if (c == null) {
      return contains(a) && contains(b);
    }

    return contains(a) && contains(b) && contains(c);
  }
}
