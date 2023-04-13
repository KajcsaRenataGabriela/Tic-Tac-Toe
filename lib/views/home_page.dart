import 'dart:math';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _boxState = <String>['', '', '', '', '', '', '', '', ''];
  bool _xTurn = Random().nextBool();
  String _whoWon = '';

  @override
  void initState() {
    super.initState();
  }

  void _checkIfSomeoneHasWon() {
    setState(() {});
    // Checking rows
    if (_boxState[0] == _boxState[1] && _boxState[0] == _boxState[2] && _boxState[0] != '') {
      _whoWon = '${_boxState[0]} won!';
    }
    if (_boxState[3] == _boxState[4] && _boxState[3] == _boxState[5] && _boxState[3] != '') {
      _whoWon = '${_boxState[3]} won!';
    }
    if (_boxState[6] == _boxState[7] && _boxState[6] == _boxState[8] && _boxState[6] != '') {
      _whoWon = '${_boxState[6]} won!';
    }

    // Checking Column
    if (_boxState[0] == _boxState[3] && _boxState[0] == _boxState[6] && _boxState[0] != '') {
      _whoWon = '${_boxState[0]} won!';
    }
    if (_boxState[1] == _boxState[4] && _boxState[1] == _boxState[7] && _boxState[1] != '') {
      _whoWon = '${_boxState[1]} won!';
    }
    if (_boxState[2] == _boxState[5] && _boxState[2] == _boxState[8] && _boxState[2] != '') {
      _whoWon = '${_boxState[2]} won!';
    }

    // Checking Diagonal
    if (_boxState[0] == _boxState[4] && _boxState[0] == _boxState[8] && _boxState[0] != '') {
      _whoWon = '${_boxState[0]} won!';
    }
    if (_boxState[2] == _boxState[4] && _boxState[2] == _boxState[6] && _boxState[2] != '') {
      _whoWon = '${_boxState[2]} won!';
    } else if (!_boxState.contains('')) {
      _whoWon = 'Tie!';
    }
    setState(() {});
  }

  void _tapped(int index) {
    setState(() {
      if (_whoWon == '') {
        if (_xTurn && _boxState[index] == '') {
          _boxState[index] = 'Pink';
          _xTurn = false;
        } else if (!_xTurn && _boxState[index] == '') {
          _boxState[index] = 'Blue';
          _xTurn = true;
        }
        _checkIfSomeoneHasWon();
      }
    });
  }

  void _refresh() {
    _boxState = <String>['', '', '', '', '', '', '', '', ''];
    _xTurn = Random().nextBool();
    _whoWon = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          Text(_whoWon=='' ? "Pink's turn\n$_whoWon" : _whoWon,
              style: TextStyle(color: _xTurn == true || _whoWon!='' ? Colors.pinkAccent : Colors.white, fontSize: 38),
              textAlign: TextAlign.center),
          TextButton(
              onPressed: _whoWon.contains('Pink') || _whoWon.contains('Tie') ? _refresh : null,
              style: ButtonStyle(
                  backgroundColor: _whoWon.contains('Pink') || _whoWon.contains('Tie')
                      ? MaterialStateProperty.all(Colors.red)
                      : null),
              child: Text(_whoWon.contains('Pink') || _whoWon.contains('Tie') ? 'Reset' : '',
                  style: const TextStyle(color: Colors.black, fontSize: 32))),
          GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      _tapped(index);
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
                  style: TextStyle(color: _whoWon.contains('Blue') || _whoWon.contains('Tie') ? Colors.black : Colors.white, fontSize: 32))),
          Text(_whoWon=='' ? "Blue's turn\n$_whoWon" : _whoWon,
              style: TextStyle(color: _xTurn == false || _whoWon!='' ? Colors.cyanAccent : Colors.white, fontSize: 38), textAlign: TextAlign.center)
        ]));
  }
}
