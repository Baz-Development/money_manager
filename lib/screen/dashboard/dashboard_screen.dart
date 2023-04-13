import 'package:flutter/material.dart';
import 'package:money_manager/models/transactions_models/user_transaction_model.dart';
import 'package:money_manager/repository/firebase_user_transactions_repository.dart';
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
  var _dateFormatted = "";
  List<Category> _kCategories = [];

  @override
  void initState() {
    super.initState();
    _dateFormatted = formatDate(_dateTabBar);
    _loadkCategories();
  }

  Future<void> _loadkCategories() async {
    try {
      var categories = await getCategories(_dateTabBar);
      setState(() {
        _kCategories = categories;
      });
    } on Exception {
      // do something
    }
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
                  onPressed: () async {
                    debugPrint("back clicked");
                    var date = subtractOneMonth(_dateTabBar);
                    var formatted = formatDate(_dateTabBar);
                    var categories = await getCategories(date);
                    setState(() {
                      _dateTabBar = date;
                      _dateFormatted = formatted;
                      _kCategories = categories;
                    });
                    debugPrint(_dateFormatted);
                  },
                  icon: const Icon(
                      Icons.arrow_back_ios
                  )
              ),
              Text(_dateFormatted),
              IconButton(
                  onPressed: () async {
                    debugPrint("next clicked");
                    var date = addOneMonth(_dateTabBar);
                    var formatted = formatDate(date);
                    var categories = await getCategories(date);
                    setState(() {
                      _dateTabBar = date;
                      _dateFormatted = formatted;
                      _kCategories = categories;
                    });
                    debugPrint(_dateFormatted);
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

  Future<List<Category>> getCategories(DateTime date) async {
    var category = await getCategoryValues(date);
    return category;
  }

  Future<List<Category>> getCategoryValues(DateTime date) async {
    var transactions = await getTransactionsByMonth(date);
    var map = {};
    List<Category> list = [];
    for (UserTransactionModel transaction in transactions.transactions) {
      if (!map.keys.contains(transaction.category)) {
        switch (transaction.type.toUpperCase()) {
          case "RECEITAS":
            map[transaction.category] = transaction.currency;
            list.add(
              Category(
                transaction.category,
                amount: transaction.currency
              )
            );
            break;
          case "INVESTIMENTOS":
            map[transaction.category] = transaction.currency;
            list.add(
              Category(
                transaction.category,
                amount: transaction.currency
              )
            );
            break;
          case "DESPESAS":
            map[transaction.category] = -transaction.currency;
            list.add(
              Category(
                transaction.category,
                amount: -transaction.currency
              )
            );
            break;
          case "DESPESAS CARTÃO":
            map[transaction.category] = -transaction.currency;
            list.add(
              Category(
                transaction.category,
                amount: -transaction.currency
              )
            );
            break;
        }
      } else {
        switch (transaction.type.toUpperCase()) {
          case "RECEITAS":
            map[transaction.category] += transaction.currency;
            var transactionRes = list.firstWhere((element) => element.name == transaction.category);
            transactionRes.amount += transaction.currency;
            break;
          case "INVESTIMENTOS":
            map[transaction.category] += transaction.currency;
            var transactionRes = list.firstWhere((element) => element.name == transaction.category);
            transactionRes.amount += transaction.currency;
            break;
          case "DESPESAS":
            map[transaction.category] -= transaction.currency;
            var transactionRes = list.firstWhere((element) => element.name == transaction.category);
            transactionRes.amount -= transaction.currency;
            break;
          case "DESPESAS CARTÃO":
            map[transaction.category] -= transaction.currency;
            var transactionRes = list.firstWhere((element) => element.name == transaction.category);
            transactionRes.amount -= transaction.currency;
            break;
        }
      }
    }
    return list;
  }

}