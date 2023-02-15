import 'package:flutter/material.dart';
import 'package:money_manager/widgets/custom_card_amount.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: const [
          CustomCardAmount(width: 300, height: 100, color: Colors.black26)
        ],
      ),
    );
  }
}