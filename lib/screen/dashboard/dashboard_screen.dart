import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen>{
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Dashboard Page',
      style: TextStyle(
          color: Color.fromRGBO(224, 224, 224, 1)
      ),
    );
  }
  
}