import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_manager/exceptions/FirebaseCustomException.dart';

import '../models/user_model.dart';

Future<void> createUser(User user) async {
  await FirebaseFirestore
    .instance
    .collection("users")
    .doc(user.userId)
    .set(
      {
        "fullname": user.fullname,
        "phoneNumber": user.phoneNumber,
        "email": user.email
      }
    );
}

Future<User> getUser(String userId) async {
  var res = await FirebaseFirestore
    .instance
    .collection("users")
    .doc(userId)
    .get();
  var data = res.data();
  if (data == null) {
    throw const FirebaseCustomException("Usuário não encontrado");
  }

  User user = User(
      data["fullname"],
      data["phoneNumber"],
      data["email"],
      data["userId"]
  );
  return user;
}

Future<void> editUser(User user) async {
  await FirebaseFirestore
    .instance
    .collection("users")
    .doc(user.userId)
    .update(
      {
        "fullname": user.fullname,
        "phoneNumber": user.phoneNumber,
        "email": user.email
      }
    );
}

Future<void> deleteUser(String userId) async {
  await FirebaseFirestore
      .instance
      .collection("users")
      .doc(userId)
      .delete();
}