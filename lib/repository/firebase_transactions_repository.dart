import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_manager/exceptions/FirebaseCustomException.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:uuid/uuid.dart';

Future<void> createTransaction(Transactions transaction) async {
  var uuid = const Uuid();
  var id = uuid.v4();
  var transactionsList =  await getAllTransaction(transaction.userId);

  transactionsList.add(transaction);
  await FirebaseFirestore
      .instance
      .collection("transactions")
      .doc(transaction.userId)
      .set(
      {
        "list": transactionsList
      }
  );
}

Future<Transactions> getTransaction(String userId, String transactionId) async {
  var res = await FirebaseFirestore
      .instance
      .collection("list")
      .doc(userId)
      .get();
  var data = res.data();
  if (data == null) {
    throw const FirebaseCustomException("Transação não encontrada");
  }
  List<Transactions> responseMap = data["transactions"];

  var transaction = responseMap.firstWhere((element) => element.id == transactionId);

  return transaction;
}

Future<List<Transactions>> getAllTransaction(String userId) async {
  var res = await FirebaseFirestore
      .instance
      .collection("transactions")
      .doc(userId)
      .get();
  var data = res.data();
  if (data == null) {
    throw const FirebaseCustomException("Transação não encontrada");
  }
  List<Transactions> transactions = data["list"];
  return transactions;
}

Future<void> editTransaction(String transactionId, Transactions transaction) async {
  await FirebaseFirestore
      .instance
      .collection("transactions")
      .doc(transaction.userId)
      .update(
      {
        transactionId: {
          "currency": transaction.currency,
          "currencyCode": transaction.currencyCode,
          "type": transaction.type,
          "updatedAt": DateTime.now().toIso8601String()
        }
      }
  );
}

Future<void> deleteAllTransactionsByUserId(String userId) async {
  await FirebaseFirestore
      .instance
      .collection("transactions")
      .doc(userId)
      .delete();
}