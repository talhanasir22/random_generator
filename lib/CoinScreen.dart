import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SecondButton.dart';
import 'ThemeContainer.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key});

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> with SingleTickerProviderStateMixin {
  int coincount = 1; // Initialize to 1, but we'll set to 0 when the screen starts
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipping = false;
  List<String> _results = [];
  Timer? _animationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Initialize the animation controller and animation
    _controller.addListener(() {
      setState(() {});
    });

    // Set initial value of coincount to 0
    coincount = 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationTimer?.cancel();
    super.dispose();
  }

  Future<void> _tossCoins() async {
    if (coincount <= 0) return; // Ensure the count is positive

    int heads = 0;
    int tails = 0;
    Random random = Random();
    _results = [];

    for (int i = 0; i < coincount; i++) {
      if (random.nextBool()) {
        heads++;
        _results.add('head');
      } else {
        tails++;
        _results.add('tail');
      }
    }

    setState(() {
      _isFlipping = true;
    });

    // Start flipping animation
    _controller.forward();
    _animationTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (_controller.isCompleted) {
        _controller.reverse();
      } else if (_controller.isDismissed) {
        _controller.forward();
      }
    });

    // Show the dialog after flipping animation
    await Future.delayed(const Duration(seconds: 3));
    _animationTimer?.cancel();
    _controller.stop();

    // Display results in an alert box
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.purple.shade300,
          title: const Text('Coin Flip Results',style: TextStyle(color: Colors.white),),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Heads: $heads\nTails: $tails',style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20),
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two coins per row
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      return CircleAvatar(
                        backgroundImage: AssetImage(
                          _results[index] == 'head'
                              ? 'assets/Images/coin head.png'
                              : 'assets/Images/coin tail.png',
                        ),backgroundColor: Color(0xFFf4a42a)
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    setState(() {
      _isFlipping = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin', style: TextStyle(color: Colors.white)),
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
                          'Number of Coins',
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
                                if (coincount > 0) {
                                  coincount--;
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
                              controller: TextEditingController(text: coincount.toString()),
                              onChanged: (value) {
                                setState(() {
                                  coincount = int.tryParse(value) ?? 0;
                                  if (coincount > 5) {
                                    coincount = 5;
                                  }
                                  if (coincount < 0) {
                                    coincount = 0;
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
                                if (coincount < 5) {
                                  coincount++;
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
                  onPressed: coincount > 0 ? _tossCoins : null, // Disable when coincount is 0
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade300),
                  child: const Text(
                    'Toss the Coin',
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
                            ? const CircleAvatar(backgroundImage: AssetImage('assets/Images/coin tail.png'),backgroundColor: Color(0xFFf4a42a),)
                            : const CircleAvatar(backgroundImage: AssetImage('assets/Images/coin head.png'),backgroundColor: Color(0xFFf4a42a)),
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
