import 'package:flutter/material.dart';

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
      'xl_price': '40000 Tsh'
    },
    {
      'starting_point': 'Mwenge',
      'destination_point': 'Ardhi University',
      'taxi_price': '2000 Tsh',
      'bajaji_price': '15000 Tsh',
      'xl_price': '30000 Tsh'
    },
    {
      'starting_point': 'Makongo',
      'destination_point': 'Ardhi University',
      'taxi_price': '3000 Tsh',
      'bajaji_price': '15000 Tsh',
      'xl_price': '40000 Tsh'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select a ride route',
          style: TextStyle(fontSize: 25.0),
        ),
        automaticallyImplyLeading: false,
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
              // vehicle selection functionality
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
