class Transactions {
  final String? id;
  final double currency;
  final String currencyCode;
  final String type;
  final String userId;

  Transactions(this.currency, this.currencyCode, this.type, this.userId, this.id);
}