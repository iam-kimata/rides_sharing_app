import 'package:flutter/material.dart';

class ResponsePage extends StatelessWidget {
  // Static data to replace the backend call
  final List<Map<String, String>> responses = [
    {'status': 'Accepted'},
    {'status': 'Rejected'},
    {'status': 'Pending'},
  ];

  ResponsePage({super.key, required int userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Driver Response',
            style: TextStyle(),
          ),
        ),
        body: responses.isEmpty
            ? const Center(child: Text('No responses found.'))
            : SingleChildScrollView(
                child: Column(
                  children: responses.map<Widget>((response) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        leading: Icon(
                          response['status'] == 'Accepted'
                              ? Icons.check_circle
                              : response['status'] == 'Rejected'
                                  ? Icons.cancel
                                  : Icons.hourglass_empty,
                          color: response['status'] == 'Accepted'
                              ? Colors.green
                              : response['status'] == 'Rejected'
                                  ? Colors.red
                                  : Colors.amber,
                        ),
                        title:
                            Text('Status: ${response['status'] ?? 'Pending'}'),
                      ),
                    );
                  }).toList(),
                ),
              ),
      ),
    );
  }
}
