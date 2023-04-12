import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/models/user_model.dart';
import 'package:money_manager/utils/user_preferences.dart';
import 'package:money_manager/widgets/appbar_widget.dart';
import 'package:money_manager/widgets/profile_widget.dart';
import 'package:money_manager/widgets/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, true, false),
      backgroundColor: const Color.fromRGBO(18, 20, 29, 1),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'FullName',
            text: user.fullname,
            onChanged: (name) {
              EasyDebounce.debounce(
                  'debouncer-edit-profile-name',
                  const Duration(milliseconds: 1500),
                  () => {
                    debugPrint(name)
                  }
              );
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: user.email,
            onChanged: (email) {
              EasyDebounce.debounce(
                  'debouncer-edit-profile-email',
                  const Duration(milliseconds: 1500),
                  () => debugPrint(email)
              );
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: user.about,
            maxLines: 5,
            onChanged: (about) {
              EasyDebounce.debounce(
                  'debouncer-edit-profile-about',
                  const Duration(milliseconds: 1500),
                  () => debugPrint(about)
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
