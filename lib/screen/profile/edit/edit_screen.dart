import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/common/shared_preferences.dart';
import 'package:money_manager/models/user_model.dart';
import 'package:money_manager/widgets/appbar_widget.dart';
import 'package:money_manager/widgets/profile_widget.dart';
import 'package:money_manager/widgets/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  SharedPref sharedPref = SharedPref();
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      User user = User.fromJson(await sharedPref.read("user"));
      setState(() {
        _user = user;
      });
    } on Exception {
      // do something
    }
  }

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
            imagePath: _user!.imagePath,
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'FullName',
            text: _user!.fullname,
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
            text: _user!.email,
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
            text: _user!.about,
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
