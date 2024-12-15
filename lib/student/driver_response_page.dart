import 'package:flutter/material.dart';
import 'package:rides_sharing_app/student/account_page.dart';
import 'package:rides_sharing_app/student/home_page.dart';
import 'package:rides_sharing_app/student/request_ride_page.dart';

class ResponsePage extends StatelessWidget {
  final int userId;

  const ResponsePage({super.key, required this.userId});

  Future<List<Map<String, String>>> fetchResponses() async {
    return [
      {'status': 'Accepted', 'date': '2024-12-15', 'time': '14:30'},
      {'status': 'Rejected', 'date': '2024-12-14', 'time': '16:15'},
      {'status': 'Pending', 'date': '2024-12-13', 'time': '10:00'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Response'),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyHeaderDrawer(
                  token: null,
                  userId: userId,
                  role: "Chat User",
                  showRole: false,
                ),
                Container(
                  height: 3,
                  color: Colors.grey[300],
                ),
                MyDrawerList(userId: userId),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchResponses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching responses.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No responses available.'));
          }

          final responses = snapshot.data!;
          return ListView.builder(
            itemCount: responses.length,
            itemBuilder: (context, index) {
              final status = responses[index]['status'];
              final date = responses[index]['date'];
              final time = responses[index]['time'];

              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        status == 'Accepted'
                            ? Icons.check_circle
                            : (status == 'Rejected'
                                ? Icons.cancel
                                : Icons.hourglass_top),
                        color: status == 'Accepted'
                            ? Colors.green
                            : (status == 'Rejected'
                                ? Colors.red
                                : Colors.orange),
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              status!,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$date at $time',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(
                    token: '',
                  ),
                ),
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
  final int userId;

  const MyDrawerList({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(context, 1, "Home", Icons.home),
          menuItem(context, 2, "Request Ride", Icons.directions_car),
          menuItem(context, 3, "Driver Response", Icons.feedback),
        ],
      ),
    );
  }

  Widget menuItem(BuildContext context, int id, String title, IconData icon,
      [String? routeName]) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (id == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            if (id == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestPage(
                    userId: userId,
                    role: "Student",
                  ),
                ),
              );
            } else if (id == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResponsePage(userId: userId),
                ),
              );
            }
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
