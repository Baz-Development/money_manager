import 'package:flutter/material.dart';
import 'package:money_manager/screen/dashboard/monthly_expenses/categories_row.dart';
import 'package:money_manager/screen/dashboard/monthly_expenses/pie_chart.dart';
import 'package:money_manager/screen/dashboard/monthly_expenses/pie_chart_view.dart';

class MonthlyExpenses extends StatelessWidget {
  const MonthlyExpenses({
    super.key,
    required this.height, required this.kCategories,
  });

  final double height;
  final List<Category> kCategories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.43,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 15),
          const Text(
            'Monthly Expenses',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.grey
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                CategoriesRow(kCategories: kCategories),
                PieChartView(kCategories: kCategories),
              ],
            ),
          ),
        ],
      ),
    );
  }
}