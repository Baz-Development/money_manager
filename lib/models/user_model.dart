class UserModel {
  String userId;
  String fullname;
  String phoneNumber;
  String email;
  String imagePath;
  String about;

  UserModel(
      this.fullname,
      this.phoneNumber,
      this.email,
      this.userId,
      this.imagePath,
      this.about
  );

  UserModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        fullname = json['fullname'],
        phoneNumber = json['phoneNumber'],
        email = json['email'],
        imagePath = json['imagePath'],
        about = json['about'];

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'fullname': fullname,
    'phoneNumber': phoneNumber,
    'email': email,
    'imagePath': imagePath,
    'about': about,
  };
}