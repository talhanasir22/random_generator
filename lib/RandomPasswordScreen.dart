import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:random_generator/ThemeContainer.dart';
import 'SecondButton.dart';
import 'main.dart';
import 'dart:math'; // For random number generation

class CustomCheckbox extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  void _onCheckboxChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _isChecked,
      onChanged: _onCheckboxChanged,
      side: const BorderSide(color: Colors.white, width: 2),
    );
  }
}

class RandomPasswordScreen extends StatefulWidget {
  const RandomPasswordScreen({super.key});

  @override
  _RandomPasswordScreenState createState() => _RandomPasswordScreenState();
}

class _RandomPasswordScreenState extends State<RandomPasswordScreen> {
  bool isCapitalLettersChecked = false;
  bool isNumbersChecked = false;
  bool isSmallLettersChecked = false;
  bool isSpecialChecked = false;
  int passwordLength = 8; // Default password length

  // Function to generate a random password
  String generatePassword() {
    const String capitalLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String smallLetters = 'abcdefghijklmnopqrstuvwxyz';
    const String numbers = '0123456789';
    const String specialCharacters = '!@#\$%^&*()_+[]{}|;:,.<>?';

    String characters = '';
    if (isCapitalLettersChecked) characters += capitalLetters;
    if (isSmallLettersChecked) characters += smallLetters;
    if (isNumbersChecked) characters += numbers;
    if (isSpecialChecked) characters += specialCharacters;

    if (characters.isEmpty) return ''; // Return empty if no checkbox is selected

    Random random = Random();
    return List.generate(passwordLength, (index) => characters[random.nextInt(characters.length)]).join();
  }

  // Function to show alert dialog with generated password
  void _showGeneratedPassword(BuildContext context, String password) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Generated Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.purple.shade200,
          content: Text(
            password.isNotEmpty
                ? password
                : 'Please select at least one option to generate a password.',
            style: const TextStyle(color: Colors.white), // Change text color for contrast
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Colors.white)), // Change button text color
            ),
            if (password.isNotEmpty)
              IconButton(
                onPressed: () {
                  // Copy password to clipboard
                  Clipboard.setData(ClipboardData(text: password));
                  // Show a snackbar or toast message to indicate the password has been copied
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password copied to clipboard!'),duration: Duration(milliseconds: 500),
                    ),
                  );
                },
                icon: const Icon(Icons.copy, color: Colors.white),
              ), // Change button text color
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Password', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.purple.shade200,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Uppercase',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  CustomCheckbox(
                                    isChecked: isCapitalLettersChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isCapitalLettersChecked = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Lowercase',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  CustomCheckbox(
                                    isChecked: isSmallLettersChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isSmallLettersChecked = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Digits',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  CustomCheckbox(
                                    isChecked: isNumbersChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isNumbersChecked = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Symbols',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  CustomCheckbox(
                                    isChecked: isSpecialChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isSpecialChecked = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                                  'Password Size',
                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SecondButton(
                                    onpress: () {
                                      setState(() {
                                        if (passwordLength > 0) passwordLength--;
                                      });
                                    },
                                    icon: Icons.remove,
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 25),
                                      keyboardType: TextInputType.number,
                                      controller: TextEditingController(text: passwordLength.toString()),
                                      onChanged: (value) {
                                        setState(() {
                                          passwordLength = int.tryParse(value) ?? 0;
                                          if (passwordLength > 15) {
                                            passwordLength = 15; // Limit the password length to 15
                                          }
                                        });
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,  // Allow only digits
                                        LengthLimitingTextInputFormatter(15),    // Limit input to a maximum of 15 characters
                                      ],
                                    ),
                                  ),
                                  SecondButton(
                                    onpress: () {
                                      setState(() {
                                        if (passwordLength < 15) {
                                          passwordLength++;
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: passwordLength > 0 ? () {
                      String password = generatePassword();
                      _showGeneratedPassword(context, password);
                    } : null, // Disable button if passwordLength is 0
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade300),
                    child: const Text(
                      'Generate Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
