import 'dart:math';

class GameOfLife {
  // dimensione della griglia
  static const size = 30;
  // griglia di cellule 0,1
  late List<List<int>> world;

  // azzera lo stato delle cellule
  void clearWorld() {
    world = List.generate(size, (_) => List<int>.filled(size, 0));
  }

  // genera uno stato random
  void randomWorld() {
    clearWorld();

    final random = Random();
    final totalCells = random.nextInt((size * size * 0.5).round());
    var i = 0;
    do {
      var r = random.nextInt(size);
      var c = random.nextInt(size);
      if (world[r][c] == 0) {
        // se la cellula non è stata già attivata
        world[r][c] = 1;
        i++;
      }
    } while (i < totalCells);
  }

  // determina lo stato successivo della cellula
  // in base all'attuale stato dei suoi vicini
  int newState(int row, int col) {
    //
    // se [row,col] è la posizione della cella da valutare
    // i suoi vicini sono:
    //
    // [t,l  ]    [t,col]  [t,r  ]
    // [row,l]   [row,col] [row,r]
    // [bl   ]    [b,col]  [br   ]
    //

    // effetto PacMan
    int t = (row > 0) ? (row - 1) : (size - 1);
    int b = (row < (size - 1)) ? (row + 1) : 0;

    int l = (col > 0) ? (col - 1) : (size - 1);
    int r = (col < (size - 1)) ? (col + 1) : 0;

    int neighborsAlive = world[t][l] +
        world[t][col] +
        world[t][r] +
        world[row][l] +
        world[row][r] +
        world[b][l] +
        world[b][col] +
        world[b][r];

    int newState = 0;
    // Qualsiasi cella viva con meno di due celle vive adiacenti muore;
    if ((world[row][col] == 1) && (neighborsAlive < 2)) {
      newState = 0;
    }
    // Qualsiasi cella viva con due o tre celle vive adiacenti sopravvive;
    if ((world[row][col] == 1) &&
        (neighborsAlive == 2 || neighborsAlive == 3)) {
      newState = 1;
    }
    // Qualsiasi cella viva con più di tre celle vive adiacenti muore;
    if ((world[row][col] == 1) && (neighborsAlive > 3)) {
      newState = 0;
    }
    // Qualsiasi cella morta con esattamente tre celle vive adiacenti diventa una cella viva;
    if ((world[row][col] == 0) && (neighborsAlive == 3)) {
      newState = 1;
    }
    return newState;
  }
}
