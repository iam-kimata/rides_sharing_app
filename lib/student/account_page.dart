import 'package:flutter/material.dart';
import 'package:rides_sharing_app/student/edit_profile.dart';
import 'package:rides_sharing_app/student/home_page.dart';
import 'package:rides_sharing_app/student/request_ride_page.dart';
import 'package:rides_sharing_app/student/driver_response_page.dart';

class ProfileScreen extends StatefulWidget {
  final String token;

  const ProfileScreen({super.key, required this.token});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock user data
  final userData = {
    'fullname': 'Aloyce Kimata',
    'phonenumber': '0784132299',
    'email': 'kimataaloyce444@gmail.com',
  };

  var currentPage = DrawerSections.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(
                    userData: userData,
                  ),
                ),
              );
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
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyHeaderDrawer(
                  token: widget.token,
                  userId: 1,
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

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Home", Icons.home, false),
          menuItem(2, "Request Ride", Icons.directions_car, false),
          menuItem(3, "Driver Response", Icons.feedback, false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else if (id == 2) {
              currentPage = DrawerSections.request;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RequestPage(
                    userId: 1,
                    role: "Student",
                  ),
                ),
              );
            } else if (id == 3) {
              currentPage = DrawerSections.response;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResponsePage(
                    userId: 1,
                  ),
                ),
              );
            }
          });
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
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
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

enum DrawerSections { home, request, response }

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
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen(token: '')),
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
