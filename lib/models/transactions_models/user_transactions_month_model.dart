import 'package:money_manager/models/transactions_models/user_transaction_model.dart';

class UserTransactionMonthModel {
  List<UserTransactionModel> transactions;
  String date;

  UserTransactionMonthModel(
    this.date,
    this.transactions,
  );

  UserTransactionMonthModel.fromJson(Map<String, dynamic> json)
    : date = json['date'],
      transactions = json['transactions'];

  Map<String, dynamic> toJson() => {
    'date': date,
    'transactions': transactions
  };
}