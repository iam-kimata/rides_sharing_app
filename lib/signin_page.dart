import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rides_sharing_app/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rides_sharing_app/signup_page.dart';
import 'package:rides_sharing_app/student/home_page.dart';
import 'package:rides_sharing_app/driver/home_page.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // ---------------- BACKEND FUNCTION ADDED ---------------- //
  Future<void> signUserIn(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    var url = Uri.parse('$baseUrl/login');

    try {
      var response = await http.post(
        url,
        body: {
          'email': username,
          'password': password,
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        String token = responseData['token'];
        String role = responseData['user']['role'];
        int id = responseData['user']['id'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setInt('userId', id);
        await prefs.setString('role', role);

        // ROLE-BASED NAVIGATION
        switch (role) {
          case 'Student':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
            break;

          case 'Driver':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePageDriver(),
              ),
            );
            break;

          default:
            print("Unknown role: $role");
        }
      } else {
        var errorData = json.decode(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Login failed: ${errorData['message']}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.directions_car,
                size: 120,
              ),
              const SizedBox(height: 50),
              const Text(
                'ARDHI UNIVERSITY STUDENT\'S RIDES SHARING APP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 25),

              // SIGN IN BUTTON (BACKEND ADDED)
              Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  onTap: () => signUserIn(context), // ← BACKEND LOGIN HERE
                  child: const Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupPage()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 230),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '@${DateTime.now().year}, All Rights Reserved',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom TextField widget
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
