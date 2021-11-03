import 'package:flutter/material.dart';

import 'package:sudoku/sudoku.dart';
import 'package:sudoku/widgets/region_widget.dart';

class Board extends StatefulWidget {
  const Board({
    Key? key,
    required this.sudoku,
  }) : super(key: key);

  final Sudoku sudoku;

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (List<SudokuRegion> row in widget.sudoku.board) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (SudokuRegion chunk in row) ...[
                RegionWidget(tiles: generateTiles(chunk.tiles))
              ],
            ],
          ),
        ],
      ],
    );
  }
}
