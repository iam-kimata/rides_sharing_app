import 'dart:js';

import 'package:flutter/material.dart';
import 'package:rides_sharing_app/student/drivers_selection.dart';
import 'package:rides_sharing_app/student/driver_response_page.dart';
import 'package:rides_sharing_app/student/account_page.dart';

class RequestPage extends StatefulWidget {
  final int userId;
  final String role;

  const RequestPage({super.key, required this.userId, required this.role});

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  List<Map<String, String>> routes = [
    {
      'starting_point': 'Ubungo',
      'destination_point': 'Ardhi University',
      'taxi_price': '3000 Tsh',
      'bajaji_price': '2000 Tsh',
      'xl_price': '4000 Tsh'
    },
    {
      'starting_point': 'Mwenge',
      'destination_point': 'Ardhi University',
      'taxi_price': '2000 Tsh',
      'bajaji_price': '1500 Tsh',
      'xl_price': '3000 Tsh'
    },
    {
      'starting_point': 'Makongo',
      'destination_point': 'Ardhi University',
      'taxi_price': '3000 Tsh',
      'bajaji_price': '1500 Tsh',
      'xl_price': '4000 Tsh'
    }
  ];

  var currentPage = DrawerSections.request;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select a ride route',
          style: TextStyle(fontSize: 25.0),
        ),
        automaticallyImplyLeading: true, // Ensures the hamburger menu is shown
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyHeaderDrawer(
                  token: null,
                  userId: widget.userId,
                  role: widget.role,
                  showRole: false,
                ),
                Container(
                  height: 3,
                  color: Colors.grey[300],
                ),
                MyDrawerList(currentPage: currentPage),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                          'Select a Vehicle from ${routes[index]['starting_point']} to ${routes[index]['destination_point']}'),
                      content: VehicleSelectionWidget(
                        taxiPrice: routes[index]['taxi_price']!,
                        bajajiPrice: routes[index]['bajaji_price']!,
                        xlPrice: routes[index]['xl_price']!,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(
                      '${routes[index]['starting_point']} to ${routes[index]['destination_point']}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class VehicleSelectionWidget extends StatelessWidget {
  final String taxiPrice;
  final String bajajiPrice;
  final String xlPrice;

  const VehicleSelectionWidget({
    super.key,
    required this.taxiPrice,
    required this.bajajiPrice,
    required this.xlPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildVehicleItem(context, 'Taxi', taxiPrice, 4),
          _buildVehicleItem(context, 'Bajaji', bajajiPrice, 3),
          _buildVehicleItem(context, 'XL', xlPrice, 6),
        ],
      ),
    );
  }

  Widget _buildVehicleItem(
      BuildContext context, String name, String price, int capacity) {
    IconData iconData;
    Color iconColor;
    switch (name) {
      case 'Taxi':
        iconData = Icons.directions_car;
        iconColor = Colors.black;
        break;
      case 'Bajaji':
        iconData = Icons.local_shipping;
        iconColor = Colors.black;
        break;
      case 'XL':
        iconData = Icons.directions_bus;
        iconColor = Colors.black;
        break;
      default:
        iconData = Icons.directions_car;
        iconColor = Colors.black;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            size: 30.0,
            color: iconColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(price),
                Row(
                  children: [
                    const Icon(Icons.group, size: 16.0),
                    const SizedBox(width: 4),
                    Text('$capacity people'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DriverListPage(
                          tripId: 1,
                          userId: 1,
                          selectedPriceType: 'standard',
                        )),
              );
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            child: const Text('Select'),
          ),
        ],
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
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen(
                            token: '',
                          )),
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

class MyDrawerList extends StatelessWidget {
  final DrawerSections currentPage;

  const MyDrawerList({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Home", Icons.home, currentPage == DrawerSections.home),
          menuItem(2, "Request Ride", Icons.directions_car,
              currentPage == DrawerSections.request),
          menuItem(3, "Driver Response", Icons.feedback,
              currentPage == DrawerSections.response),
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
          if (id == 2) {
            Navigator.push(
              context as BuildContext,
              MaterialPageRoute(
                builder: (context) => const RequestPage(
                  userId: 1,
                  role: "Student",
                ),
              ),
            );
          } else if (id == 3) {
            Navigator.push(
              context as BuildContext,
              MaterialPageRoute(
                builder: (context) => ResponsePage(userId: 1),
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

enum DrawerSections {
  home,
  request,
  response,
}
