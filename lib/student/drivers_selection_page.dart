import 'package:flutter/material.dart';

class Driver {
  final int id;
  final String name;
  final String phoneNumber;
  final String plateNumber;

  Driver({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.plateNumber,
  });
}

class DriverListPage extends StatelessWidget {
  final List<Driver> drivers;

  DriverListPage({required this.drivers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Available drivers'),
      ),
      body: ListView.builder(
        itemCount: drivers.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('lib/images/profile.png'),
              ),
              title: Text(drivers[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phone: ${drivers[index].phoneNumber}'),
                  Text('Plate Number: ${drivers[index].plateNumber}'),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  // Handle the ride request action here, if necessary
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
