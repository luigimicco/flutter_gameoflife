import 'dart:math';

class GameOfLife {
  // dimensione della griglia
  static const size = 30;
  // griglia di cellule 0,1
  late List<List<int>> world;
  // numero di cellule attive
  int population = 0;

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
  int newState(int y, int x) {
    //
    // se [y,x] è la posizione della cella da valutare
    // i suoi vicini sono:
    //
    // [t,l] [t,c] [t,r]
    // [r,l] [y,x] [r,r]
    // [b,l] [b,c] [b,r]
    //

    // effetto PacMan
    int t = (y > 0) ? (y - 1) : (size - 1);
    int b = (y < (size - 1)) ? (y + 1) : 0;

    int l = (x > 0) ? (x - 1) : (size - 1);
    int r = (x < (size - 1)) ? (x + 1) : 0;

    int neighborsAlive = world[t][l] +
        world[t][x] +
        world[t][r] +
        world[y][l] +
        world[y][r] +
        world[b][l] +
        world[b][x] +
        world[b][r];

    int newState = 0;
    // Qualsiasi cella viva con meno di due celle vive adiacenti muore;
    if ((world[y][x] == 1) && (neighborsAlive < 2)) {
      newState = 0;
    }
    // Qualsiasi cella viva con due o tre celle vive adiacenti sopravvive;
    if ((world[y][x] == 1) && (neighborsAlive == 2 || neighborsAlive == 3)) {
      newState = 1;
    }
    // Qualsiasi cella viva con più di tre celle vive adiacenti muore;
    if ((world[y][x] == 1) && (neighborsAlive > 3)) {
      newState = 0;
    }
    // Qualsiasi cella morta con esattamente tre celle vive adiacenti diventa una cella viva;
    if ((world[y][x] == 0) && (neighborsAlive == 3)) {
      newState = 1;
    }
    return newState;
  }

  // valuta lo stato successivo per tutte le cellule
  List<List<int>> nextWorld() {
    // crea un mondo nuovo vuoto
    List<List<int>> newWorld =
        List.generate(size, (_) => List<int>.filled(size, 0));

    population = 0;
    for (var row = 0; row < size; ++row) {
      for (var col = 0; col < size; ++col) {
        newWorld[row][col] = newState(row, col);
        // conta le celle attive
        population += newWorld[row][col];
      }
    }

    return newWorld;
  }
}
