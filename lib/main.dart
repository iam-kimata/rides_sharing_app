import 'package:flutter/material.dart';
import 'package:rides_sharing_app/driver/account_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(token: '',),
    );
  }
}