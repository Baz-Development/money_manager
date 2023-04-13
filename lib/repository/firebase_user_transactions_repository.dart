import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:money_manager/models/transactions_models/user_transaction_model.dart';
import 'package:money_manager/models/transactions_models/user_transactions_month_model.dart';
import 'package:uuid/uuid.dart';

Future<void> createTransaction(UserTransactionModel transaction) async {
  var userId = FirebaseAuth.instance.currentUser?.uid;
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

Future<UserTransactionMonthModel> getTransactionsByMonth(DateTime date) async {
  var userId = FirebaseAuth.instance.currentUser?.uid;
  var formattedDate = formatDate(date);
  var querySnapshot  = await FirebaseFirestore
      .instance
      .collection("transactions")
      .doc(userId)
      .collection(formattedDate)
      .get();

  final List<QueryDocumentSnapshot> documentos = querySnapshot.docs;
  List<UserTransactionModel> list_res = [];
  for (QueryDocumentSnapshot documento in documentos) {
    final Map<String, dynamic> dados = documento.data() as Map<String, dynamic>;
    var transaction = UserTransactionModel.fromJson(dados);
    list_res.add(transaction);
  }

  return UserTransactionMonthModel(formattedDate, list_res);
}

String formatDate(DateTime date) {
  String ano = date.year.toString();
  String mes = date.month.toString().padLeft(2, '0');
  return '$ano-$mes';
}