import 'dart:js';

import 'package:flutter/material.dart';
import 'package:rides_sharing_app/student/request_ride_page.dart';
import 'package:rides_sharing_app/student/account_page.dart';

class ResponsePage extends StatelessWidget {
  // Static data to replace the backend call
  final List<Map<String, String>> responses = [
    {'status': 'Accepted'},
    {'status': 'Rejected'},
    {'status': 'Pending'},
  ];

  final int userId;

  ResponsePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Driver Response',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: responses.isEmpty
          ? const Center(child: Text('No responses found.'))
          : SingleChildScrollView(
        child: Column(
          children: responses.map<Widget>((response) {
            return Card(
              margin: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 16),
              child: ListTile(
                leading: Icon(
                  response['status'] == 'Accepted'
                      ? Icons.check_circle
                      : response['status'] == 'Rejected'
                      ? Icons.cancel
                      : Icons.hourglass_empty,
                  color: response['status'] == 'Accepted'
                      ? Colors.green
                      : response['status'] == 'Rejected'
                      ? Colors.red
                      : Colors.amber,
                ),
                title: Text('Status: ${response['status'] ?? 'Pending'}'),
              ),
            );
          }).toList(),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyHeaderDrawer(
                  token: null,
                  userId: userId,
                  role: "Student",
                  showRole: false,
                ),
                Container(
                  height: 3,
                  color: Colors.grey[300],
                ),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Home", Icons.home, false),
          menuItem(2, "Request Ride", Icons.directions_car, false),
          menuItem(3, "Driver Response", Icons.feedback, true),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.pop(context as BuildContext);
          if (id == 1) {
            // Navigate to Home Page
            Navigator.pop(context as BuildContext);
          } else if (id == 2) {
            // Navigate to Request Ride Page
            Navigator.push(
              context as BuildContext,
              MaterialPageRoute(
                builder: (context) => RequestPage(
                  userId: userId,
                  role: "Student",
                ),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHeaderDrawer extends StatelessWidget {
  final String? token;
  final int userId;
  final String role;
  final bool showRole;

  const MyHeaderDrawer({
    super.key,
    required this.token,
    required this.userId,
    required this.role,
    required this.showRole,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 220,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('lib/images/user.png'),
          ),
          const SizedBox(height: 10),
          MouseRegion(
            cursor: SystemMouseCursors.click, // Pointer to a hand
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen(token: '',)),
                );
              },
              child: const Text(
                "My Account",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (showRole)
            Text(
              role,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }
}

