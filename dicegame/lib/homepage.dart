import 'dart:math';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _diceList = <String>[
    "images/d1.PNG",
    "images/d2.PNG",
    "images/d3.PNG",
    "images/d4.PNG",
    "images/d5.PNG",
    "images/d6.PNG",
  ];
  int _index1 = 0, _index2 = 0, _dicesum = 0, _point = 0;
  final _random = Random.secure();
  bool _hasgamestarted = false;
  bool _isgameOver = false;
  String _statusMsg = 'You win';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(36, 0, 0, 0),
      appBar: AppBar(
        title: const Text("Simple Dice game"),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: _hasgamestarted ? _gameSection() : _startGameSection(),
      ),
    );
  }

  Widget _startGameSection() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _hasgamestarted = true;
        });
      },
      child: const Text('start'),
    );
  }

  Widget _gameSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                _diceList[_index1],
                width: 100,
                height: 100,
              ),
              const SizedBox(
                width: 5,
              ),
              Image.asset(
                _diceList[_index2],
                width: 100,
                height: 100,
              )
            ],
          ),
        ),
        ElevatedButton(
            onPressed: _isgameOver ? null : _rolltheDice,
            child: const Text("Roll")),
        Text(
          'Dice sum: $_dicesum',
          style: const TextStyle(fontSize: 22),
        ),
        if (_point > 0)
          Text(
            'Your point: $_point',
            style: const TextStyle(fontSize: 24),
          ),
        if (_point > 0 && !_isgameOver)
          const Text(
            'keep scroling untill you win',
            style: TextStyle(fontSize: 22),
          ),
        if (_isgameOver)
          Text(
            _statusMsg,
            style: const TextStyle(fontSize: 22),
          ),
        ElevatedButton(onPressed: _resetgame, child: const Text("PLAY AGAIN")),
      ],
    );
  }

  void _rolltheDice() {
    setState(() {
      _index1 = _random.nextInt(6);
      _index2 = _random.nextInt(6);
      _dicesum = _index1 + _index2 + 2;
      if (_point > 0) {
        secoundthrow();
      } else {
        firstthrow();
      }
    });
  }

  void firstthrow() {
    switch (_dicesum) {
      case 7:
      case 11:
        _isgameOver = true;
        _statusMsg = "You win";
        break;
      case 2:
      case 3:
      case 12:
        _isgameOver = true;
        _statusMsg = "You win";
        break;
      default:
        _point = _dicesum;
    }
  }

  void secoundthrow() {
    if (_dicesum == _point) {
      _statusMsg = "you win";
      _isgameOver = true;
    } else if (_dicesum == 7) {
      _statusMsg = "you lost";
      _isgameOver = true;
    }
  }

  void _resetgame() {
    setState(() {
      _index1 = 0;
      _index2 = 0;
      _dicesum = 0;
      _point = 0;
      _isgameOver = false;
      _hasgamestarted = false;
    });
  }
}
