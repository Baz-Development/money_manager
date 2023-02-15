import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  _MoreScreenState createState() => _MoreScreenState();
}
class _MoreScreenState extends State<MoreScreen>{
  @override
  Widget build(BuildContext context) {
    return const Text(
      'More Page',
      style: TextStyle(
          color: Color.fromRGBO(224, 224, 224, 1)
      ),
    );
  }
  
}