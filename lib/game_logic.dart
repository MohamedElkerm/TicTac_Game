import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  //List of index in game
  static List<int> playerX = [];
  static List<int> playerY = [];
}

extension ContainsAll on List {
  bool containsAll(int x, int y, [z]) {
    if (z != null) {
      return contains(x) && contains(y) && contains(z);
    } else {
      return contains(x) && contains(y);
    }
  }
}

class Game {
  void playGame(int index, String activePlayer) {
    if (activePlayer == 'X') {
      Player.playerX.add(index);
    } else {
      Player.playerY.add(index);
    }
  }

  String checkWinner() {
    String winner = '';

    if (Player.playerX.containsAll(0, 1, 2) ||
        Player.playerX.containsAll(3, 4, 5) ||
        Player.playerX.containsAll(6, 7, 8) ||
        Player.playerX.containsAll(0, 3, 6) ||
        Player.playerX.containsAll(1, 4, 7) ||
        Player.playerX.containsAll(2, 5, 8) ||
        Player.playerX.containsAll(1, 4, 8) ||
        Player.playerX.containsAll(2, 4, 6)) {
      winner = 'X';
    } else if (Player.playerY.containsAll(0, 1, 2) ||
        Player.playerY.containsAll(3, 4, 5) ||
        Player.playerY.containsAll(6, 7, 8) ||
        Player.playerY.containsAll(0, 3, 6) ||
        Player.playerY.containsAll(1, 4, 7) ||
        Player.playerY.containsAll(2, 5, 8) ||
        Player.playerY.containsAll(1, 4, 8) ||
        Player.playerY.containsAll(2, 4, 6)) {
      winner = 'O';
    } else {
      winner = '';
    }
    return winner;
  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];
    for (var i = 0; i < 9; ++i) {
      if (!(Player.playerX.contains(i) || Player.playerY.contains(i))) {
        emptyCells.add(i);
       }
    }
      Random random = Random();
      int randomIndex = random.nextInt(emptyCells.length);
      index = emptyCells[randomIndex];
      playGame(index, activePlayer);

  }
}
