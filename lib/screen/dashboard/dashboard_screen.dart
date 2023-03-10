import 'package:flutter/material.dart';
import 'package:money_manager/screen/add_balance/add_balance.dart';
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
        children: [
          cardShowBalance()
        ],
      ),
    );
  }

  Widget cardShowBalance() {
    return CustomCardAmount(width: 300, height: 100, color: Colors.black26, function: () {
      debugPrint("you balance clicked");
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddBalanceScreen()));
    });
  }

}