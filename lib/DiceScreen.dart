import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dice_icons/dice_icons.dart';
import 'package:random_generator/SecondButton.dart';
import 'ThemeContainer.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> with SingleTickerProviderStateMixin {
  int diceCount = 0;
  List<int> diceResults = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipping = false;
  Timer? _animationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationTimer?.cancel();
    super.dispose();
  }

  void _rollDice() {
    setState(() {
      _isFlipping = true;
    });

    _controller.forward();
    _animationTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (_controller.isCompleted) {
        _controller.reverse();
      } else if (_controller.isDismissed) {
        _controller.forward();
      }
    });

    Future.delayed(const Duration(seconds: 3), () {
      _animationTimer?.cancel();
      _controller.stop();
      diceResults = List.generate(diceCount, (_) => Random().nextInt(6) + 1);
      setState(() {
        _isFlipping = false;
      });
      _showResultDialog();
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.purple.shade300,
          title: const Text('Dice Results', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 10,
                children: diceResults.map((result) {
                  return Icon(
                    _getDiceIcon(result),
                    size: 50,
                    color: Colors.white,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                'Total: ${diceResults.reduce((a, b) => a + b)}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  IconData _getDiceIcon(int number) {
    switch (number) {
      case 1:
        return DiceIcons.dice1;
      case 2:
        return DiceIcons.dice2;
      case 3:
        return DiceIcons.dice3;
      case 4:
        return DiceIcons.dice4;
      case 5:
        return DiceIcons.dice5;
      case 6:
        return DiceIcons.dice6;
      default:
        return DiceIcons.dice1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context); // Navigate back if keyboard is not open
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Stack(
        children: [
          const ThemeContainer(),
          Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  height: 150,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.purple.shade200,
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Number of Dices',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SecondButton(
                            onpress: () {
                              setState(() {
                                if (diceCount > 0) {
                                  diceCount--;
                                }
                              });
                            },
                            icon: Icons.remove,
                          ),
                          SizedBox(
                            width: 80,
                            child: TextField(
                              autofocus: true,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 25),
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(text: diceCount.toString()),
                              onChanged: (value) {
                                setState(() {
                                  diceCount = int.tryParse(value) ?? 0;
                                  if (diceCount > 5) {
                                    diceCount = 5;
                                  }
                                });
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(5),
                              ],
                            ),
                          ),
                          SecondButton(
                            onpress: () {
                              setState(() {
                                if (diceCount < 5) {
                                  diceCount++;
                                }
                              });
                            },
                            icon: Icons.add,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: diceCount > 0 ? _rollDice : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: diceCount > 0 ? Colors.purple.shade300 : Colors.grey,
                  ),
                  child: const Text(
                    'Roll the Dice',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_isFlipping)
                SizedBox(
                  height: 100,
                  width: 100,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(2, 1, 0.0015)
                          ..rotateY(pi * _animation.value),
                        child: _animation.value <= 0.5
                            ? const Image(image: AssetImage('assets/Images/Dice5.png'))
                            : const Image(image: AssetImage('assets/Images/Dice6.png')),
                      );
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
