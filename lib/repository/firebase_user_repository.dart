import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_manager/exceptions/FirebaseCustomException.dart';

import '../models/user_model.dart';

Future<void> createUser(UserModel user) async {
  await FirebaseFirestore
    .instance
    .collection("users")
    .doc(user.userId)
    .set(
      {
        "fullname": user.fullname,
        "phoneNumber": user.phoneNumber,
        "email": user.email,
        "imagePath": user.imagePath,
        "about": user.about
      }
    );
}

Future<UserModel> getUser(String userId) async {
  var res = await FirebaseFirestore
    .instance
    .collection("users")
    .doc(userId)
    .get();
  var data = res.data();
  if (data == null) {
    throw const FirebaseCustomException("Usuário não encontrado");
  }

  UserModel user = UserModel(
    data["fullname"],
    data["phoneNumber"],
    data["email"],
    userId,
    data["imagePath"],
    data["about"]
  );
  return user;
}

Future<void> editUserdb(UserModel user) async {
  await FirebaseFirestore
    .instance
    .collection("users")
    .doc(user.userId)
    .update(
      {
        "fullname": user.fullname,
        "phoneNumber": user.phoneNumber,
        "email": user.email,
        "imagePath": user.imagePath,
        "about": user.about
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