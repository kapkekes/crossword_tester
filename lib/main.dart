import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuple/tuple.dart';

import 'firebase_options.dart';

import 'utility.dart';
import 'crossword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CTS Alpha',
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFF5296A5)),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const MainPage()
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CTS: alpha version',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.headline1?.fontFamily,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        toolbarHeight: 35,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Crossword(
            cellSize: 18,
            cellPadding: 2,
          ),
        ],
      ),
    );
  }
}

class Crossword extends StatefulWidget {
  const Crossword({Key? key, required this.cellSize, required this.cellPadding}) : super(key: key);

  final double cellSize;
  final double cellPadding;

  @override
  State<Crossword> createState() => _CrosswordState();
}

class _CrosswordState extends State<Crossword> {
  final List<List<String?>> _answerMatrix = getAnswerMatrix();
  int cursorX = 0;
  int cursorY = 0;
  String _axis = 'n';

  Widget _buildCell (String? value, double size, int x, int y) {
    if (value == null) {
      return SizedBox(
        height: widget.cellSize,
        width: widget.cellSize,
      );
    } else if (!(value.contains(RegExp(r'[0-9]')))) {
      return Container(
        height: widget.cellSize,
        width: widget.cellSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (cursorX == x && cursorY == y && _axis != 'n') ? const Color(0xFFFFC49C) : (value == '' ? const Color(0xFFFFEEDD) : const Color(0xFFb8b8ff)),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        )
      );
    } else {
      return InkWell(
        onTap: () {
          setState(() {
            if (_answerMatrix[x][y + 1] == null) {
              _axis = 'h';
              cursorX = x + 1;
              cursorY = y;
            } else {
              _axis = 'v';
              cursorX = x;
              cursorY = y + 1;
            }
          });
        }, // Handle your callback
        child: Ink(
          height: widget.cellSize,
          width: widget.cellSize,
          decoration: BoxDecoration(
            color: const Color(0xFFFFC49C),
            border: Border.all(
              color: Colors.grey,
              width: 1
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            height: widget.cellSize,
            width: widget.cellSize,
            alignment: Alignment.center,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        ),
      );
    }
  }

  List<TableRow> _buildTableRows(double size, double padding) {
    List<TableRow> result = [];
    var rowFlag = true;
    var columnFlag = true;
    for (var i = 0; i < _answerMatrix.length; i += 1) {
      columnFlag = true;
      if (rowFlag) {
        List<Widget> rowChildren = [];
        for (var j = 0; j < _answerMatrix[i].length; j += 1) {
          if (columnFlag) {
            rowChildren.add(_buildCell(_answerMatrix[i][j], size, i, j));
            columnFlag = false;
          } else {
            rowChildren.add(SizedBox(width: padding));
            j -= 1;
            columnFlag = true;
          }
        }
        result.add(TableRow(children: rowChildren));
        rowFlag = false;
      } else {
        List<Widget> rowChildren = [];
        var border = _answerMatrix[i].length * 2 - 1;
        for (var j = 0; j < border; j += 1) {
          rowChildren.add(SizedBox(height: padding));
        }
        result.add(TableRow(children: rowChildren));
        i -= 1;
        rowFlag = true;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (input) => {
        if (_axis != 'n' && input is RawKeyDownEvent) {
          if ('abcdefghijklmnopqrstuvwxyz&'.contains(input.logicalKey.keyLabel.toLowerCase())) {
            setState(() {
              _answerMatrix[cursorX][cursorY] = input.logicalKey.keyLabel.toLowerCase();
              if (_axis == 'h') {
                if (_answerMatrix[cursorX + 1][cursorY] != null) {
                  cursorX += 1;
                } else {
                  _axis = 'n';
                }
              } else {
                if (_answerMatrix[cursorX][cursorY + 1] != null) {
                  cursorY += 1;
                } else {
                  _axis = 'n';
                }
              }
            })
          } else if (input.logicalKey.keyLabel == 'Backspace') {
            setState(() {
              _answerMatrix[cursorX][cursorY] = '';
              if (_axis == 'h') {
                if (!positions.contains(Tuple2(cursorX - 1, cursorY))) {
                  cursorX -= 1;
                } else {
                  _axis = 'n';
                }
              } else {
                if (!positions.contains(Tuple2(cursorX, cursorY - 1))) {
                  cursorY -= 1;
                } else {
                  _axis = 'n';
                }
              }
            })
          }
        }
      },
      child: Table(
        defaultColumnWidth: const IntrinsicColumnWidth(),
        children: _buildTableRows(widget.cellSize, widget.cellPadding),
      )
    );
  }
}

class CluesSection extends StatelessWidget {
  const CluesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: 600,
      child: ListView(
        addAutomaticKeepAlives: true,
        children: cookedClues
      ),
    );
  }
}

