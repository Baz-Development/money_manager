import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}
class _TransactionsScreenState extends State<TransactionsScreen>{
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Transactions Page',
      style: TextStyle(
          color: Color.fromRGBO(224, 224, 224, 1)
      ),
    );
  }
  
}