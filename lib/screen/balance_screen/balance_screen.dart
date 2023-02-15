import 'package:flutter/material.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}
class _BalanceScreenState extends State<BalanceScreen>{
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Balance Page',
      style: TextStyle(
          color: Color.fromRGBO(224, 224, 224, 1)
      ),
    );
  }
}