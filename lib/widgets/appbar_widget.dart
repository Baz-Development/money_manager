import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/models/user_model.dart';
import 'package:money_manager/screen/profile/profile_screen.dart';
import 'package:money_manager/utils/user_preferences.dart';
import 'package:money_manager/widgets/profile_widget.dart';

AppBar buildAppBar(BuildContext context, bool hasBack, bool haveProfileIcon) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  const icon = CupertinoIcons.moon_stars;
  final user = UserPreferences.myUser;

  return AppBar(
    leading: Back(hasBack),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: profileImageChecker(context, user, haveProfileIcon)
      ),
    ],
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

Widget? profileImageChecker(BuildContext context, User user, bool hasProfileImage) {

  if(hasProfileImage) {
    return ProfileWidget(
      imagePath: user.imagePath,
      actions: false,
      onClicked: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      },
      height: 40,
      width: 40,
    );
  }
  return null;
}

Widget? Back(bool hasBack) {
  if(hasBack){
    return const BackButton();
  }
  return null;
}
