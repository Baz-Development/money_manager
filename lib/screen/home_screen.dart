import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(18, 20, 29, 1),
      body: Center(
        child: Text(
            'Home Page',
          style: TextStyle(
            color: Color.fromRGBO(224, 224, 224, 1)
          ),
        ),
      ),
    );
  }
}