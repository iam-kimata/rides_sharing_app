import 'package:flutter/material.dart';
import 'package:rides_sharing_app/driver/home_page.dart';
import 'package:rides_sharing_app/driver/trips_page.dart';
import 'package:rides_sharing_app/driver/account_page.dart';

class MainPageDriver extends StatefulWidget {
  const MainPageDriver({super.key});

  @override
  _MainPageDriverState createState() => _MainPageDriverState();
}

class _MainPageDriverState extends State<MainPageDriver> {
  int _currentIndex = 0;

  // Screens for each section
  final List<Widget> _pages = [
    HomePageDriver(),
    TripsPage(),
    const ProfileScreenDriver(token: '',),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the current screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
