import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background_image.png"),
              fit: BoxFit.cover
          ),
        ),
        child: const Center(
          child: Text(
              'Home Page',
            style: TextStyle(
              color: Color.fromRGBO(224, 224, 224, 1)
            ),
          ),
        ),
      ),
    );
  }
}