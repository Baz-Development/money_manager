class UserTransactionModel {
  String userId;
  double currency;
  String currencyCode;
  String type;
  String category;

  UserTransactionModel(
    this.userId,
    this.currency,
    this.currencyCode,
    this.type,
    this.category
  );

  UserTransactionModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        currency = json['currency'],
        currencyCode = json['currencyCode'],
        type = json['type'],
        category = json['category'];

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'currency': currency,
    'currencyCode': currencyCode,
    'type': type,
    'category': category
  };
}