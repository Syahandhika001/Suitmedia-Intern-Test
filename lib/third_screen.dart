import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ... other imports

class ThirdScreen extends StatefulWidget {
  final String selectedUserName;

  const ThirdScreen({Key? key, required this.selectedUserName})
      : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> users = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$currentPage&per_page=10'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        users.addAll(
            (data['data'] as List).map((e) => User.fromJson(e)).toList());
        currentPage++;
        hasMoreData = data['total_pages'] > currentPage;
        isLoading = false;
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: RefreshIndicator(
        onRefresh: () => fetchUsers(),
        child: ListView.builder(
          itemCount: users.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == users.length) {
              return Center(child: CircularProgressIndicator());
            }
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.avatar),
              ),
              title: Text('${user.firstName} ${user.lastName}'),
              subtitle: Text(user.email),
              onTap: () {
                Navigator.pop(
                    context, user.fullName); // Pass selected user name
              },
            );
          },
        ),
      ),
      // ... other parts of the widget
    );
  }
}

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

  String get fullName => '$firstName $lastName';
}
