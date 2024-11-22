import 'package:flutter/material.dart';

class HomePageDriver extends StatelessWidget {
  HomePageDriver({super.key});

  // Dummy data for ride requests
  final List<Map<String, dynamic>> rideRequests = [
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Ride Requests',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: _buildRideRequests(),
    );
  }

  Widget _buildRideRequests() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: rideRequests.isNotEmpty
          ? ListView.builder(
              itemCount: rideRequests.length,
              itemBuilder: (context, index) {
                final rideRequest = rideRequests[index];
                return RideRequestCard(
                  name: rideRequest['fullname'],
                  phoneNumber: rideRequest['phonenumber'],
                  pickUpLocation: rideRequest['starting_point'],
                  destinationLocation: rideRequest['destination_point'],
                  price: rideRequest['price'],
                  date: rideRequest['created_at'],
                  onAccept: () {
                    // Handle accept button
                  },
                  onReject: () {
                    // Handle reject button
                  },
                );
              },
            )
          : const Center(
              child: Text(
                "No active ride requests",
                style: TextStyle(fontSize: 16),
              ),
            ),
    );
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
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New Request',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('Full Name: $name'),
            Text('Phone Number: $phoneNumber'),
            Text('Pick up Point: $pickUpLocation'),
            Text('Destination Point: $destinationLocation'),
            Text('Price: $price'),
            Text('Date: $date'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onAccept,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(const Size(100, 50)),
                  ),
                  child: const Text('Accept'),
                ),
                ElevatedButton(
                  onPressed: onReject,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(const Size(100, 50)),
                  ),
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
