import 'package:flutter/material.dart';
import 'package:money_manager/screen/add_balance/add_balance.dart';
import 'package:money_manager/screen/dashboard/monthly_expenses/categories_row.dart';
import 'package:money_manager/screen/dashboard/monthly_expenses/monthly_expenses.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/screen/dashboard/monthly_expenses/pie_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen>{
  var _dateTabBar = DateTime.now();
  var _dateFormated = "";
  List<Category> _kCategories = [];

  @override
  void initState() {
    super.initState();
    _dateFormated = formatDate(_dateTabBar);
    _kCategories = getCategories(_dateTabBar.month);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  debugPrint("Receitas tap");
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddBalanceScreen(type: "Receitas", color: Colors.green)),
                  );
                },
                child: Column(
                  children: const [
                    Icon(
                      Icons.trending_up,
                      color: Colors.green,
                    ),
                    Text(
                      "Receitas",
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  debugPrint("Despesas tap");
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddBalanceScreen(type: "Despesas", color: Colors.red)),
                  );
                },
                child: Column(
                  children: const [
                    Icon(
                      Icons.trending_down,
                      color: Colors.red,
                    ),
                    Text(
                      "Despesas",
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: (){
                    debugPrint("back clicked");
                    var date = subtractOneMonth(_dateTabBar);
                    var formated = formatDate(_dateTabBar);
                    var categories = getCategories(date.month);
                    setState(() {
                      _dateTabBar = date;
                      _dateFormated = formated;
                      _kCategories = categories;
                    });
                    debugPrint(_dateFormated);
                  },
                  icon: const Icon(
                      Icons.arrow_back_ios
                  )
              ),
              Text(_dateFormated),
              IconButton(
                  onPressed: (){
                    debugPrint("next clicked");
                    var date = addOneMonth(_dateTabBar);
                    var formated = formatDate(date);
                    var categories = getCategories(date.month);
                    setState(() {
                      _dateTabBar = date;
                      _dateFormated = formated;
                      _kCategories = categories;
                    });
                    debugPrint(_dateFormated);
                  },
                  icon: const Icon(
                      Icons.arrow_forward_ios
                  )
              )
            ],
          ),
        ),
        const SizedBox(height: 50),
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
                  height: height,
                  kCategories: _kCategories,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  DateTime subtractOneMonth(DateTime date) {
    var newDate = DateTime(date.year, date.month - 1, date.day);
    return newDate;
  }

  DateTime addOneMonth(DateTime date) {
    var newDate = DateTime(date.year, date.month + 1, date.day);
    return newDate;
  }

  String formatDate(DateTime date) {
    final monthFormat = DateFormat('MMMM', "pt-BR");
    final yearFormat = DateFormat.y();
    final month = monthFormat.format(date).capitalize();
    final year = yearFormat.format(date);
    return '$month - $year';
  }

  List<Category> getCategories(int month) {
    if(month % 2 == 0) {
      return [
        Category('groceries', amount: 500.00),
        Category('online Shopping', amount: 150.00),
        Category('eating', amount: 90.00),
        Category('bills', amount: 90.00),
        Category('subscriptions', amount: 40.00),
        Category('fees', amount: 20.00),
      ];
    } else {
      return [
        Category('groceries', amount: 250.00),
        Category('online Shopping', amount: 100.00),
        Category('eating', amount: 100.00),
        Category('bills', amount: 200.00),
        Category('subscriptions', amount: 80.00),
        Category('fees', amount: 90.00),
      ];
    }
  }

}