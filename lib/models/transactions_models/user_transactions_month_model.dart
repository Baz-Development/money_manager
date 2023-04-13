class UserTransactionMonthModel {
  List<UserTransactionMonthModel> transactions;
  double date;

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