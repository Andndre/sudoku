import 'package:flutter/material.dart';
import 'package:sudoku/sudoku.dart';
import 'package:sudoku/widgets/square_widget.dart';

class RegionWidget extends StatefulWidget {
  const RegionWidget({Key? key, required this.tiles}) : super(key: key);

  final List<List<SquareWidget>> tiles;

  @override
  _RegionWidgetState createState() => _RegionWidgetState();
}

class _RegionWidgetState extends State<RegionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 1.5),
          bottom: BorderSide(color: Colors.black, width: 1.5),
          right: BorderSide(color: Colors.black, width: 1.5),
          left: BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
      child: Column(
        children: [
          for (List<SquareWidget> row in widget.tiles) Row(children: row)
        ],
      ),
    );
  }
}

List<List<SquareWidget>> generateTiles(List<List<SudokuSquare>> tile) {
  List<List<SquareWidget>> result = [];

  for (int i = 0; i < 3; i++) {
    result.add([]);
    for (int j = 0; j < 3; j++) {
      result[i].add(
        SquareWidget(
          tile: tile[i][j],
        ),
      );
    }
  }

  return result;
}
