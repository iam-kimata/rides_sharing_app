import 'package:flutter/material.dart';

class TripsPage extends StatelessWidget {
  TripsPage({super.key});

  // Sample ride request data for display
  final List<Map<String, dynamic>> rideRequests = [
    {
      'starting_point': 'Makongo',
      'destination_point': 'Ardhi University',
      'created_at': '2024-11-22 14:00:00',
      'price': '2000',
      'status': 'Accepted',
    },
    {
      'starting_point': 'Kijitonyama',
      'destination_point': 'Mwenge',
      'created_at': '2024-11-22 12:30:00',
      'price': '1500',
      'status': 'Rejected',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'My Trips',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: _buildRideRequests(),
    );
  }

  Widget _buildRideRequests() {
    return rideRequests.isNotEmpty
        ? ListView.builder(
            itemCount: rideRequests.length,
            itemBuilder: (context, index) {
              final ride = rideRequests[index];
              return TripInfo(
                pickupPoint: ride['starting_point'] ?? '',
                destinationPoint: ride['destination_point'] ?? '',
                dateTime: ride['created_at'] ?? '',
                price: double.parse(ride['price']),
                status: ride['status'] ?? '',
              );
            },
          )
        : const Center(
            child: Text('No ride requests found'),
          );
  }
}

class TripInfo extends StatelessWidget {
  final String pickupPoint;
  final String destinationPoint;
  final String dateTime;
  final double price;
  final String status;

  const TripInfo({
    super.key,
    required this.pickupPoint,
    required this.destinationPoint,
    required this.dateTime,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pick up Point: $pickupPoint',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Destination Point: $destinationPoint',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Date: $dateTime',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Price: ${price.toStringAsFixed(2)} Tsh',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Status: $status',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
