import 'dart:math';

class GameOfLife {
  // dimensione della griglia
  static const size = 30;
  // griglia di cellule 0,1
  late List<List<int>> world;
  // numero di cellule attive
  int population = 0;
  // generazione corrente
  int generation = 0;

  // ritorna la dimensione della griglia
  int getSize() {
    return size;
  }

  // ritorna lo stato di una cella
  bool isAlive(int row, int col) {
    return (world[row][col] == 1);
  }

  // azzera lo stato delle cellule
  void clearWorld() {
    population = 0;
    generation = 0;
    world = List.generate(size, (_) => List<int>.filled(size, 0));
  }

  // genera uno stato random
  void randomWorld() {
    clearWorld();

    final random = Random();
    final totalCells = random.nextInt((size * size * 0.2).round()) +
        (size * size * 0.2).round();
    int i = 0;
    do {
      int r = random.nextInt(size);
      int c = random.nextInt(size);
      // se la cellula non è stata già attivata
      if (!isAlive(r, c)) {
        world[r][c] = 1;
        i++;
      }
    } while (i < totalCells);
    population = totalCells;
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
    if (isAlive(y, x) && (neighborsAlive < 2)) {
      newState = 0;
    }
    // Qualsiasi cella viva con due o tre celle vive adiacenti sopravvive;
    if (isAlive(y, x) && (neighborsAlive == 2 || neighborsAlive == 3)) {
      newState = 1;
    }
    // Qualsiasi cella viva con più di tre celle vive adiacenti muore;
    if (isAlive(y, x) && (neighborsAlive > 3)) {
      newState = 0;
    }
    // Qualsiasi cella morta con esattamente tre celle vive adiacenti diventa una cella viva;
    if (!isAlive(y, x) && (neighborsAlive == 3)) {
      newState = 1;
    }
    return newState;
  }

  // aggiorna lo stato per tutte le cellule
  // a passa alla generazione successiva
  void nextWorld() {
    // crea un mondo nuovo vuoto
    List<List<int>> newWorld =
        List.generate(size, (_) => List<int>.filled(size, 0));

    population = 0;
    for (int row = 0; row < size; ++row) {
      for (int col = 0; col < size; ++col) {
        newWorld[row][col] = newState(row, col);
        // conta le celle attive
        population += newWorld[row][col];
      }
    }
    generation++;
    world = newWorld;
  }
}
