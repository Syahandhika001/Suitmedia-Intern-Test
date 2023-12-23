import 'package:flutter/material.dart';
import 'third_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // Perpindahan shadow
          ),
        ],
      ),
      child: AppBar(
        title: Center(child: Text(title)),
        elevation: 0, // Hilangkan shadow AppBar bawaan
        backgroundColor: Color.fromARGB(
            255, 255, 255, 255), // Ubah latar belakang menjadi transparan
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  final String name;
  String selectedUserName;

  SecondScreen({required this.name, required this.selectedUserName});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  void updateSelectedUserName(String userName) {
    setState(() {
      widget.selectedUserName = userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Second Screen'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome", style: TextStyle(fontSize: 12)),
            SizedBox(height: 18),
            Text(widget.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: Center(
                child: Text(
                  "Selected User Name: ${widget.selectedUserName}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF2B637B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThirdScreen(
                          selectedUserName: widget.selectedUserName,
                        ),
                      ),
                    );
                    if (result != null) {
                      updateSelectedUserName(result);
                    }
                  },
                  child: Text(
                    "Choose a User",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
