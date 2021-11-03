import 'dart:math';

class Sudoku {
  /// ```dart
  ///  [['4', '3', '5',   '2', '6', '9',   '7', '8', '1'],
  ///   ['6', '8', '2',   '5', '7', '1',   '4', '9', '3'],
  ///   ['1', '9', '7',   '8', '3', '4',   '5', '6', '2'],
  ///
  ///   ['8', '2', '6',   '1', '9', '5',   '3', '4', '7'],
  ///   ['3', '7', '4',   '6', '8', '2',   '9', '1', '5'],
  ///   ['9', '5', '1',   '7', '4', '3',   '6', '2', '8'],
  ///
  ///   ['5', '1', '9',   '3', '2', '6',   '8', '7', '4'],
  ///   ['2', '4', '8',   '9', '5', '7',   '1', '3', '6'],
  ///   ['7', '6', '3',   '4', '1', '8',   '2', '5', '9']],
  ///
  ///
  /// ```
  static final List<List<SudokuRegion>> _base = [
    [
      SudokuRegion(tiles: [
        [
          SudokuSquare(value: '4'),
          SudokuSquare(value: '3'),
          SudokuSquare(value: '5')
        ],
        [
          SudokuSquare(value: '6'),
          SudokuSquare(value: '8'),
          SudokuSquare(value: '2')
        ],
        [
          SudokuSquare(value: '1'),
          SudokuSquare(value: '9'),
          SudokuSquare(value: '7'),
        ]
      ]),
      SudokuRegion(tiles: [
        [
          SudokuSquare(value: '2'),
          SudokuSquare(value: '6'),
          SudokuSquare(value: '9')
        ],
        [
          SudokuSquare(value: '5'),
          SudokuSquare(value: '7'),
          SudokuSquare(value: '1')
        ],
        [
          SudokuSquare(value: '8'),
          SudokuSquare(value: '3'),
          SudokuSquare(value: '4'),
        ]
      ]),
      SudokuRegion(tiles: [
        [
          SudokuSquare(value: '7'),
          SudokuSquare(value: '8'),
          SudokuSquare(value: '1')
        ],
        [
          SudokuSquare(value: '4'),
          SudokuSquare(value: '9'),
          SudokuSquare(value: '3')
        ],
        [
          SudokuSquare(value: '5'),
          SudokuSquare(value: '6'),
          SudokuSquare(value: '2'),
        ]
      ])
    ],
    [
      SudokuRegion(tiles: [
        [
          SudokuSquare(value: '8'),
          SudokuSquare(value: '2'),
          SudokuSquare(value: '6'),
        ],
        [
          SudokuSquare(value: '3'),
          SudokuSquare(value: '7'),
          SudokuSquare(value: '4'),
        ],
        [
          SudokuSquare(value: '9'),
          SudokuSquare(value: '5'),
          SudokuSquare(value: '1'),
        ]
      ]),
      SudokuRegion(tiles: [
        [
          SudokuSquare(value: '1'),
          SudokuSquare(value: '9'),
          SudokuSquare(value: '5'),
        ],
        [
          SudokuSquare(value: '6'),
          SudokuSquare(value: '8'),
          SudokuSquare(value: '2'),
        ],
        [
          SudokuSquare(value: '7'),
          SudokuSquare(value: '4'),
          SudokuSquare(value: '3'),
        ]
      ]),
      SudokuRegion(tiles: [
        [
          SudokuSquare(value: '3'),
          SudokuSquare(value: '4'),
          SudokuSquare(value: '7')
        ],
        [
          SudokuSquare(value: '9'),
          SudokuSquare(value: '1'),
          SudokuSquare(value: '5')
        ],
        [
          SudokuSquare(value: '6'),
          SudokuSquare(value: '2'),
          SudokuSquare(value: '8'),
        ]
      ])
    ],
    [
      SudokuRegion(tiles: [
        [
          SudokuSquare(value: '5'),
          SudokuSquare(value: '1'),
          SudokuSquare(value: '9')
        ],
        [
          SudokuSquare(value: '2'),
          SudokuSquare(value: '4'),
          SudokuSquare(value: '8')
        ],
        [
          SudokuSquare(value: '7'),
          SudokuSquare(value: '6'),
          SudokuSquare(value: '3'),
        ]
      ]),
      SudokuRegion(tiles: [
        [
          SudokuSquare(value: '3'),
          SudokuSquare(value: '2'),
          SudokuSquare(value: '6')
        ],
        [
          SudokuSquare(value: '9'),
          SudokuSquare(value: '5'),
          SudokuSquare(value: '7')
        ],
        [
          SudokuSquare(value: '4'),
          SudokuSquare(value: '1'),
          SudokuSquare(value: '8'),
        ]
      ]),
      SudokuRegion(tiles: [
        [
          SudokuSquare(value: '8'),
          SudokuSquare(value: '7'),
          SudokuSquare(value: '4')
        ],
        [
          SudokuSquare(value: '1'),
          SudokuSquare(value: '3'),
          SudokuSquare(value: '6')
        ],
        [
          SudokuSquare(value: '2'),
          SudokuSquare(value: '5'),
          SudokuSquare(value: '9'),
        ]
      ])
    ]
  ];

  List<List<SudokuRegion>> get base => _base;

  List<List<SudokuRegion>> board;

  static Sudoku random() {
    Sudoku sudoku = Sudoku(board: _base).copy();

    sudoku.shuffle();

    return sudoku;
  }

  Sudoku({required this.board});

  Sudoku copy() {
    List<List<SudokuRegion>> newBoard = [];
    for (int i = 0; i < 3; i++) {
      newBoard.add([]);
      for (int j = 0; j < 3; j++) {
        SudokuRegion newChunk = board[i][j].copy();
        newBoard[i].add(newChunk);
      }
    }
    return Sudoku(board: newBoard);
  }

  /// Combine [_shuffleChunk] and [_shuffleTile]
  void shuffle({int iteration = 5}) {
    for (int i = 0; i < iteration; i++) {
      _shuffleChunk();
      _shuffleTile();
    }
  }

  /// Re-arrange [SudokuRegion] vertically and horizontally
  void _shuffleChunk({List<List<SudokuRegion>>? board}) {
    board ??= this.board;
    List<IntPair> horizontal = IntPair.generateRandomSwapPairs(3);
    List<IntPair> vertical = IntPair.generateRandomSwapPairs(3);

    for (IntPair sp in vertical) {
      for (int i = 0; i < 3; i++) {
        SudokuRegion tmp = board[i][sp.a];
        board[i][sp.a] = board[i][sp.b];
        board[i][sp.b] = tmp;
      }
    }

    for (IntPair sp in horizontal) {
      for (int i = 0; i < 3; i++) {
        SudokuRegion tmp = board[sp.a][i];
        board[sp.a][i] = board[sp.b][i];
        board[sp.b][i] = tmp;
      }
    }
  }

  /// Re-arrange [SudokuSquare] vertically and horizontally
  void _shuffleTile({List<List<SudokuRegion>>? board}) {
    board ??= this.board;
    // horizontal
    for (int i = 0; i < 3; i++) {
      List<IntPair> swapPairList = IntPair.generateRandomSwapPairs(3);
      for (IntPair swapPair in swapPairList) {
        for (int j = 0; j < 3; j++) {
          SudokuRegion chunk = board[i][j];
          for (int k = 0; k < 3; k++) {
            SudokuSquare tmp = chunk.tiles[swapPair.a][k];
            chunk.tiles[swapPair.a][k] = chunk.tiles[swapPair.b][k];
            chunk.tiles[swapPair.b][k] = tmp;
          }
        }
      }
    }

    // vertical
    for (int i = 0; i < 3; i++) {
      List<IntPair> swapPairList = IntPair.generateRandomSwapPairs(3);
      for (IntPair swapPair in swapPairList) {
        for (int j = 0; j < 3; j++) {
          SudokuRegion chunk = board[j][i];
          for (int k = 0; k < 3; k++) {
            SudokuSquare tmp = chunk.tiles[k][swapPair.a];
            chunk.tiles[k][swapPair.a] = chunk.tiles[k][swapPair.b];
            chunk.tiles[k][swapPair.b] = tmp;
          }
        }
      }
    }
  }

  /// Hide [SudokuSquare] by some [probability].
  void rehide([int probability = 50]) {
    // board have 3 row of chunks
    for (List<SudokuRegion> row in board) {
      // row have 3 chunks
      for (SudokuRegion chunk in row) {
        // chunk.tiles have 3 row of tiles
        for (List<SudokuSquare> rowTile in chunk.tiles) {
          // rowTile have 3 elements
          for (SudokuSquare tile in rowTile) {
            if (Random().nextInt(100) < probability) {
              tile.revealed = false;
            } else {
              tile.revealed = true;
            }
          }
        }
      }
      // total iteration above should be 3^4 or 81 (tile count in sudoku)
    }
  }

  //  Displays the [board] to the console
  // void display() {
  //   print('_' * 31);
  //   for (List<SudokuRegion> row in board) {
  //     for (int i = 0; i < 3; i++) {
  //       String str = '| ';
  //       for (SudokuRegion chunk in row) {
  //         str +=
  //             '${chunk.tiles[i][0].toString()}  ${chunk.tiles[i][1].toString()}  ${chunk.tiles[i][2].toString()} | ';
  //       }
  //       print(str);
  //     }
  //     print('|' + ('_________|' * 3));
  //   }
  // }
}

class SudokuRegion {
  List<List<SudokuSquare>> tiles;
  SudokuRegion({
    required this.tiles,
  });

  SudokuRegion copy() {
    List<List<SudokuSquare>> newChunk = [];
    for (int i = 0; i < 3; i++) {
      newChunk.add([]);
      for (int j = 0; j < 3; j++) {
        SudokuSquare newTile = SudokuSquare(value: tiles[i][j].value);
        newChunk[i].add(newTile);
      }
    }
    return SudokuRegion(tiles: newChunk);
  }

  @override
  String toString() {
    return tiles.toString();
  }
}

/// Pair of two `int`
class IntPair {
  int a;
  int b;
  IntPair({
    required this.a,
    required this.b,
  });

  /// Generates a [List] of random `unique` [IntPair]s
  /// in range `[0, size)`.
  static List<IntPair> generateRandomSwapPairs(int size) {
    final List<IntPair> result = [];

    final List<int> options = List.generate(size, (index) => index);

    while (options.length > 1) {
      result.add(
          IntPair(a: options.removeAtRandom(), b: options.removeAtRandom()));
    }

    if (options.length == 1) {
      result.add(IntPair(a: options[0], b: _randExcpt(size, options[0])));
    }

    return result;
  }

  @override
  String toString() {
    return [a, b].toString();
  }
}

class SudokuSquare {
  bool revealed;
  String value;

  SudokuSquare({required this.value, this.revealed = true});

  @override
  String toString() {
    return revealed ? value : ' ';
  }
}

int _randExcpt(int max, int except) {
  if (max <= 1) return -1;
  final Random rand = Random();
  int result = rand.nextInt(max);
  while (result == except) {
    result = rand.nextInt(max);
  }

  return result;
}

extension _Random on List {
  /// Removes the object at random position from this list.
  /// Returns the removed value.
  /// The list must be growable.
  int removeAtRandom() {
    int idx = Random().nextInt(length);
    return removeAt(idx);
  }
}
