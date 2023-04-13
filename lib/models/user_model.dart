class User {
  final String userId;
  final String fullname;
  final String phoneNumber;
  final String email;
  final String imagePath;
  final String about;

  User(
      this.fullname,
      this.phoneNumber,
      this.email,
      this.userId,
      this.imagePath,
      this.about
  );

  User.fromJson(Map<String, dynamic> json)
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