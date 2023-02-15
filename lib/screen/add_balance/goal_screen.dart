import 'package:flutter/material.dart';

class AddBalanceScreen extends StatefulWidget {
  const AddBalanceScreen({super.key});

  @override
  _AddBalanceScreenState createState() => _AddBalanceScreenState();
}
class _AddBalanceScreenState extends State<AddBalanceScreen>{
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Add Balance Page',
      style: TextStyle(
          color: Color.fromRGBO(224, 224, 224, 1)
      ),
    );
  }
  
}