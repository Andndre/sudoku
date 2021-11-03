import 'package:flutter/material.dart';
import 'package:sudoku/sudoku.dart';

class SquareWidget extends StatefulWidget {
  const SquareWidget({
    Key? key,
    required this.tile,
  }) : super(key: key);

  final SudokuSquare tile;

  @override
  _SquareWidgetState createState() => _SquareWidgetState();
}

class _SquareWidgetState extends State<SquareWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.tile.revealed = !widget.tile.revealed;
        });
      },
      child: Container(
        width: size.width / 9 - 2,
        height: size.width / 9 - 2,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black, width: 0.5),
            right: BorderSide(color: Colors.black, width: 0.5),
            left: BorderSide(color: Colors.black, width: 0.5),
            bottom: BorderSide(color: Colors.black, width: 0.5),
          ),
        ),
        child: Center(
          child: Text(
            widget.tile.revealed ? widget.tile.value : ' ',
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
