import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(18, 20, 29, 1),
      body: Center(
        child: Text(
          'Welcome Page',
          style: TextStyle(
              color: Color.fromRGBO(224, 224, 224, 1)
          ),
        ),
      ),
    );
  }
}