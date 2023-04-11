import 'package:flutter/material.dart';
import 'package:money_manager/models/circular_chart_data.dart';
import 'package:money_manager/screen/dashboard/monthly_expenses/monthly_expenses.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen>{
  @override
  Widget build(BuildContext context) {
    final List<CircularChartData> chartData = [
      CircularChartData('David', 25),
      CircularChartData('Steve', 38),
      CircularChartData('Jack', 34),
      CircularChartData('Others', 52)
    ];

    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        children: <Widget>[
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: GestureDetector(
              onTap: () {
                debugPrint("Monthly expenses tap");
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(48, 48, 55, 1.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15, top: 15),
                  child: MonthlyExpenses(
                    height: height
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}