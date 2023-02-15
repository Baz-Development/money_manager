import 'package:flutter/material.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  _GoalScreenState createState() => _GoalScreenState();
}
class _GoalScreenState extends State<GoalScreen>{
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Goal Page',
      style: TextStyle(
          color: Color.fromRGBO(224, 224, 224, 1)
      ),
    );
  }
  
}