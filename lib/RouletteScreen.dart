import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'ThemeContainer.dart';
import 'dart:math';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> {
  final TextEditingController RouletteController = TextEditingController();
  List<String> items = [];
  StreamController<int>? selected;

  @override
  void dispose() {
    selected?.close();
    super.dispose();
  }

  void _initializeStream() {
    selected?.close(); // Close any previous StreamController
    selected = StreamController<int>();
  }

  void _addItem() {
    if (RouletteController.text.isEmpty) {
      _showErrorDialog('Please enter an item to add.');
      return;
    }
    if (items.length >= 10) {
      _showErrorDialog('Maximum of 10 items can be added.');
      return;
    }
    setState(() {
      items.add(RouletteController.text);
      RouletteController.clear();
      _showAddItemSnackbar();
    });
  }

  void _spinWheel() {
    if (items.length < 2) {
      _showErrorDialog('Please add at least two items to spin.');
      return;
    }
    _initializeStream(); // Initialize a new stream

    final random = Random().nextInt(items.length);
    selected!.add(random);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Spinner',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.purple.shade300,
          content: SizedBox(
            height: 200,
            child: FortuneWheel(
              items: [
                for (var item in items)
                  FortuneItem(
                    child: Text(item, style: const TextStyle(color: Colors.white)),
                    style: const FortuneItemStyle(
                      color: Colors.blue,
                      borderColor: Colors.blueAccent,
                      borderWidth: 3.0,
                    ),
                  ),
              ],
              selected: selected!.stream,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showResultDialog(items[random]);
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    ).then((_) {
      setState(() {
        items.clear();
      });
    });
  }

  void _showResultDialog(String selectedItem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.purple.shade300,
          title: const Text('Result',style: TextStyle(color: Colors.white),),
          content: Text('Selected: $selectedItem',style: const TextStyle(color: Colors.white),),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK',),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.purple.shade300,
          title: const Text('Error',style: TextStyle(color: Colors.white),),
          content: Text(message,style: const TextStyle(color: Colors.white),),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK',),
            ),
          ],
        );
      },
    );
  }

  void _showAddItemSnackbar(){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item Added Successfully'),
          duration: Duration(milliseconds: 500))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Roulette',
          style: TextStyle(color: Colors.white),
        ),
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
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    height: 130,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.purple.shade200,
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Item Name',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 280,
                          child: TextField(
                            autofocus: true,
                            style: const TextStyle(fontSize: 18),
                            controller: RouletteController,
                            maxLength: 12,
                            decoration: const InputDecoration(
                              counterText: '',
                              hintText: 'Enter the item to spin',
                              hintStyle: TextStyle(color: Colors.white38),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: _addItem,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade300,
                        ),
                        child: const Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: items.isNotEmpty ? _spinWheel : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: items.isNotEmpty
                              ? Colors.purple.shade300
                              : Colors.grey,
                        ),
                        child: const Text(
                          'Spin',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
