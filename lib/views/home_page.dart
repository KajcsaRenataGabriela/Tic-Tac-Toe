import 'dart:math';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _boxState = List<String>.filled(9, '');
  bool _xTurn = Random().nextBool();
  String _whoWon = '';

  @override
  void initState() {
    super.initState();
  }

  void checkForWinner() {
    setState(() {});

    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (_boxState[i].isNotEmpty && _boxState[i] == _boxState[i + 1] && _boxState[i] == _boxState[i + 2]) {
        _whoWon = '${_boxState[i]} won!';
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_boxState[i].isNotEmpty && _boxState[i] == _boxState[i + 3] && _boxState[i] == _boxState[i + 6]) {
        _whoWon = '${_boxState[i]} won!';
        return;
      }
    }

    // Check diagonals
    if (_boxState[0].isNotEmpty && _boxState[0] == _boxState[4] && _boxState[0] == _boxState[8]) {
      _whoWon = '${_boxState[0]} won!';
      return;
    }
    if (_boxState[2].isNotEmpty && _boxState[2] == _boxState[4] && _boxState[2] == _boxState[6]) {
      _whoWon = '${_boxState[2]} won!';
      return;
    }

    // Check for tie
    if (!_boxState.contains('')) {
      _whoWon = 'Tie!';
    }
  }

  void tapped(int index) {
    if (_whoWon != '') {
      return; // Return early if there's already a winner
    }

    if (_boxState[index] != '') {
      return; // Return early if the box is already taken
    }

    if (_xTurn) {
      _boxState[index] = 'Pink';
    } else {
      _boxState[index] = 'Blue';
    }

    _xTurn = !_xTurn; // Switch the turn to the other player
    checkForWinner(); // Check if anyone has won
    setState(() {}); // Update the UI
  }

  void _refresh() {
    _boxState = List<String>.filled(9, '');
    _xTurn = Random().nextBool();
    _whoWon = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          RotatedBox(
              quarterTurns: 2,
              child: Text(_whoWon == '' ? "Pink's turn\n$_whoWon" : _whoWon,
                  style: TextStyle(
                      color: _xTurn == true || _whoWon != '' ? Colors.pinkAccent : Colors.white, fontSize: 38),
                  textAlign: TextAlign.center)),
          RotatedBox(
              quarterTurns: 2,
              child: TextButton(
                  onPressed: _whoWon.contains('Pink') || _whoWon.contains('Tie') ? _refresh : null,
                  style: ButtonStyle(
                      backgroundColor: _whoWon.contains('Pink') || _whoWon.contains('Tie')
                          ? MaterialStateProperty.all(Colors.red)
                          : null),
                  child: Text(_whoWon.contains('Pink') || _whoWon.contains('Tie') ? 'Reset' : '',
                      style: const TextStyle(color: Colors.black, fontSize: 32)))),
          GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      tapped(index);
                    },
                    child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: Center(
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                color: _boxState[index].isNotEmpty
                                    ? _boxState[index] == 'Pink'
                                        ? Colors.pinkAccent
                                        : Colors.cyanAccent
                                    : Colors.white))));
              }),
          TextButton(
              onPressed: _whoWon.contains('Blue') || _whoWon.contains('Tie') ? _refresh : null,
              style: ButtonStyle(
                  backgroundColor: _whoWon.contains('Blue') || _whoWon.contains('Tie')
                      ? MaterialStateProperty.all(Colors.red)
                      : null),
              child: Text('Reset',
                  style: TextStyle(
                      color: _whoWon.contains('Blue') || _whoWon.contains('Tie') ? Colors.black : Colors.white,
                      fontSize: 32))),
          Text(_whoWon == '' ? "Blue's turn\n$_whoWon" : _whoWon,
              style:
                  TextStyle(color: _xTurn == false || _whoWon != '' ? Colors.cyanAccent : Colors.white, fontSize: 38),
              textAlign: TextAlign.center)
        ]));
  }
}
