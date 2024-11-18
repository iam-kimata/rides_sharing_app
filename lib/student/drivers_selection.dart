import 'package:flutter/material.dart';

class Driver {
  final int id;
  final String fullName;
  final String phoneNumber;
  final String plateNumber;

  Driver({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.plateNumber,
  });
}

class DriverListPage extends StatefulWidget {
  final int tripId;
  final int userId;
  final String selectedPriceType;

  DriverListPage({
    required this.tripId,
    required this.userId,
    required this.selectedPriceType,
  });

  @override
  _DriverListPageState createState() => _DriverListPageState();
}

class _DriverListPageState extends State<DriverListPage> {
  // Mocked data for drivers
  List<Driver> drivers = [
    Driver(
      id: 1,
      fullName: "John Doe",
      phoneNumber: "0785457654",
      plateNumber: "T908 BBG",
    ),
    Driver(
      id: 2,
      fullName: "Jane Smith",
      phoneNumber: "0654328765",
      plateNumber: "T564 DFR",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Available Drivers'),
      ),
      body: ListView.builder(
        itemCount: drivers.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('lib/images/user.png'),
              ),
              title: Text(drivers[index].fullName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phone: ${drivers[index].phoneNumber}'),
                  Text('Plate Number: ${drivers[index].plateNumber}'),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  // Placeholder for button action
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text(
                  'Request',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
