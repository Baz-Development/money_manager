import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_manager/models/transactions_models/user_transaction_model.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

Future<void> createTransaction(UserTransactionModel transaction) async {
  var instance = FirebaseAuth.instance;
  var user = instance.currentUser;
  var userId = user?.uid;
  var date = DateTime.now();
  var formattedDate = formatDate(date);
  String uuid = const Uuid().v4();

  await FirebaseFirestore
    .instance
    .collection("transactions")
    .doc(userId)
    .collection(formattedDate)
    .doc(uuid)
    .set(
    {
      'userId': transaction.userId,
      'currency': transaction.currency,
      'currencyCode': transaction.currencyCode,
      'type': transaction.type,
      'category': transaction.category
    }
  );
}

String formatDate(DateTime date) {
  final monthFormat = DateFormat.m();
  final yearFormat = DateFormat.y();
  final month = monthFormat.format(date);
  final year = yearFormat.format(date);
  return '$year-$month';
}