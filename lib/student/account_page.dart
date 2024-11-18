import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String token;

  const ProfileScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    // Mock user data
    final userData = {
      'fullname': 'Aloyce Kimata',
      'phonenumber': '0784132299',
      'email': 'kimataaloyce444@gmail.com',
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              // Action for the Edit button
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage('lib/images/user.png'),
              ),
              const SizedBox(height: 20),
              itemProfile('Full Name', userData['fullname']!, Icons.person),
              const SizedBox(height: 15),
              itemProfile(
                  'Phone Number', userData['phonenumber']!, Icons.phone),
              const SizedBox(height: 15),
              itemProfile('Email', userData['email']!, Icons.mail),
              const SizedBox(height: 45),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Logout implementation
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 5),
            spreadRadius: 0.2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}
