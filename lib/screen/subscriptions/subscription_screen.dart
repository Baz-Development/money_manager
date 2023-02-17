import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>{
  @override
  Widget build(BuildContext context) {
    return const Text(
      'subscription Page',
      style: TextStyle(
          color: Color.fromRGBO(224, 224, 224, 1)
      ),
    );
  }
  
}