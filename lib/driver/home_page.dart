import 'package:flutter/material.dart';
import 'package:rides_sharing_app/driver/trips_page.dart';
import 'package:rides_sharing_app/driver/account_page.dart';

class HomePageDriver extends StatefulWidget {
  const HomePageDriver({super.key});

  @override
  State<HomePageDriver> createState() => _HomePageDriverState();
}

class _HomePageDriverState extends State<HomePageDriver> {
  int _currentIndex = 0;

  // Pages for each BottomNavigationBar item
  final List<Widget> _pages = [
    const RideRequestsPage(),         // Home
    TripsPage(),                      // Trips
    ProfileScreenDriver(token: ''),   // Account
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Show AppBar only for the first page
      appBar: _currentIndex == 0
          ? AppBar(
        title: const Text(
          'Ride Requests',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      )
          : null,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Trips'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}

// ---------------- Home Page ----------------
class RideRequestsPage extends StatelessWidget {
  const RideRequestsPage({super.key});

  final List<Map<String, dynamic>> rideRequests = const [
    {
      'fullname': 'Paul Kenedy',
      'phonenumber': '0784132299',
      'starting_point': 'Makongo',
      'destination_point': 'Ardhi University',
      'price': '2000 Tsh',
      'created_at': '2024-11-22 14:00:00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return rideRequests.isNotEmpty
        ? ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rideRequests.length,
      itemBuilder: (context, index) {
        final ride = rideRequests[index];
        return RideRequestCard(
          name: ride['fullname'],
          phoneNumber: ride['phonenumber'],
          pickUpLocation: ride['starting_point'],
          destinationLocation: ride['destination_point'],
          price: ride['price'],
          date: ride['created_at'],
          onAccept: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Ride Accepted")));
          },
          onReject: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Ride Rejected")));
          },
        );
      },
    )
        : const Center(child: Text("No active ride requests"));
  }
}

class RideRequestCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String pickUpLocation;
  final String destinationLocation;
  final String price;
  final String date;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const RideRequestCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.pickUpLocation,
    required this.destinationLocation,
    required this.price,
    required this.date,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('New Request',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Full Name: $name'),
            Text('Phone Number: $phoneNumber'),
            Text('Pick Up: $pickUpLocation'),
            Text('Destination: $destinationLocation'),
            Text('Price: $price'),
            Text('Date: $date'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Accept'),
                ),
                ElevatedButton(
                  onPressed: onReject,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Reject'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
