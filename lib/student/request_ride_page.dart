import 'package:flutter/material.dart';
import 'package:rides_sharing_app/student/home_page.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select a ride route',
          style: TextStyle(fontSize: 25.0),
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
                  userId: widget.userId,
                  role: widget.role,
                  showRole: false,
                ),
                Container(height: 3, color: Colors.grey[300]),
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Select a Vehicle from ${routes[index]['starting_point']} to ${routes[index]['destination_point']}',
                      ),
                      content: VehicleSelectionWidget(
                        taxiPrice: routes[index]['taxi_price']!,
                        bajajiPrice: routes[index]['bajaji_price']!,
                        xlPrice: routes[index]['xl_price']!,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        )
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
                    '${routes[index]['starting_point']} → ${routes[index]['destination_point']}',
                  ),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildVehicleItem(context, 'Taxi', taxiPrice, 4),
        _buildVehicleItem(context, 'Bajaji', bajajiPrice, 3),
        _buildVehicleItem(context, 'XL', xlPrice, 6),
      ],
    );
  }

  Widget _buildVehicleItem(
      BuildContext context, String name, String price, int capacity) {
    IconData icon = Icons.directions_car;

    if (name == 'Bajaji') icon = Icons.local_shipping;
    if (name == 'XL') icon = Icons.directions_bus;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(price),
                Row(
                  children: [
                    const Icon(Icons.group, size: 16),
                    const SizedBox(width: 5),
                    Text("$capacity people")
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DriverListPage(
                    tripId: 1,
                    userId: 1,
                    selectedPriceType: "standard",
                  ),
                ),
              );
            },
            child: const Text("Select"),
          )
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
      height: 220,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("lib/images/user.png"),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen(token: "")));
            },
            child: const Text(
              "My Account",
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
          if (showRole) Text(role),
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
    return Column(
      children: [
        menuItem(context, 1, "Home", Icons.home),
        menuItem(context, 2, "Request Ride", Icons.directions_car),
        menuItem(context, 3, "Driver Response", Icons.feedback),
      ],
    );
  }

  Widget menuItem(BuildContext context, int id, String title, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);

        if (id == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (id == 2) {
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResponsePage(userId: 1)),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(icon, size: 22),
            const SizedBox(width: 20),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

enum DrawerSections { home, request, response }
