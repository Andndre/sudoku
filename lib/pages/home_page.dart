import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sudoku/sudoku.dart';
import 'package:sudoku/widgets/board_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Sudoku sudoku = Sudoku.random()..rehide(50);
  double hidePercentage = 50;
  final ScreenshotController _controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Sudoku Puzzle Generator',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Screenshot(
                  controller: _controller,
                  child: Board(
                    sudoku: sudoku,
                  ),
                ),
              ),
              Slider(
                value: hidePercentage,
                onChanged: (newValue) {
                  setState(() {
                    hidePercentage = newValue;
                  });
                },
                min: 0,
                max: 100,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'You can hide/reveal the number by clicking on it',
                  overflow: TextOverflow.clip,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final Uint8List? img = await _controller.capture();
                        if (img == null) return;
                        await saveAndShareImage(img);
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Share',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.share,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          // showSolution = false;
                          sudoku = Sudoku.random()
                            ..rehide(hidePercentage.toInt());
                        });
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Generate',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.refresh,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveAndShareImage(Uint8List byte) async {
    final String time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    final Directory directory = await getApplicationDocumentsDirectory();
    final File image = File('${directory.path}/sudoku_$time.png');
    image.writeAsBytesSync(byte);

    await Share.shareFiles([image.path]);
  }
}
