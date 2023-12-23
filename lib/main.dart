import 'package:flutter/material.dart';
import 'second_screen.dart';
import 'third_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palindrome Checker',
      home: FirstScreen(),
      routes: {
        '/third': (context) => ThirdScreen(selectedUserName: 'username'),
      },
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _nameController = TextEditingController();
  final _sentenceController = TextEditingController();

  bool isPalindrome(String text) {
    for (int i = 0; i < text.length / 2; i++) {
      if (text[i] != text[text.length - i - 1]) {
        return false;
      }
    }
    return true;
  }

  void checkPalindrome() {
    String name = _nameController.text;
    String sentence = _sentenceController.text;

    bool isPalindromeResult = isPalindrome(sentence);

    String message = isPalindromeResult ? "isPalindrome" : "not palindrome";
    _showDialog(message);
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Palindrome"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bgFirstScreen.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Color.fromARGB(100, 255, 255, 255),
                  child: Icon(Icons.person, size: 50.0),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Nama",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33.0),
                  child: TextField(
                    controller: _sentenceController,
                    decoration: InputDecoration(
                      labelText: "Palindrome",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Column(
                  children: [
                    SizedBox(
                      width:
                          double.infinity, // Lebar seukuran dengan kolom nama
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 33.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF2B637B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: checkPalindrome,
                          child: Text(
                            'CHECK',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0), // Spasi antar tombol
                    SizedBox(
                      width: double
                          .infinity, // Lebar seukuran dengan kolom palindrom
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 33.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF2B637B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () {
                            // Navigasi ke second page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SecondScreen(
                                  name: _nameController.text,
                                  selectedUserName: '',
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'NEXT',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
