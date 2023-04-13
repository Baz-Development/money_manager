import 'package:flutter/material.dart';
import 'package:money_manager/common/shared_preferences.dart';
import 'package:money_manager/models/user_model.dart';
import 'package:money_manager/screen/profile/edit/edit_screen.dart';
import 'package:money_manager/widgets/appbar_widget.dart';
import 'package:money_manager/widgets/button_widget.dart';
import 'package:money_manager/widgets/numbers_widget.dart';
import 'package:money_manager/widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPref sharedPref = SharedPref();
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      UserModel user = UserModel.fromJson(await sharedPref.read("user"));
      setState(() {
        _user = user;
      });
    } on Exception {
      // do something
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: buildAppBar(context, true, false),
      backgroundColor: const Color.fromRGBO(18, 20, 29, 1),
      body: ListView(
        children: [
          ProfileWidget(
            imagePath: _user!.imagePath,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditProfilePage()),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(_user!),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 24),
          buildAbout(_user!),
          const SizedBox(height: 24),
          const CardMeuPerfil(),
          const SizedBox(height: 5),
          const CardMinhasAssinaturas(),
        ],
      ),
    );
  }

  Widget buildName(UserModel user) => Column(
    children: [
      Text(
        user.fullname,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.grey
        ),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: const TextStyle(
          color: Colors.grey
        ),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'hehehe',
    onClicked: () {},
  );

  Widget buildPhoneNumber(UserModel user) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone Number',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
        ),
        const SizedBox(height: 16),
        Text(
          user.phoneNumber,
          style: const TextStyle(
              fontSize: 16,
              height: 1.4,
              color: Colors.grey
          ),
        ),
      ],
    ),
  );

  Widget buildAbout(UserModel user) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          ),
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: const TextStyle(
            fontSize: 16,
            height: 1.4,
            color: Colors.grey
          ),
        ),
      ],
    ),
  );
}

class CardMinhasAssinaturas extends StatelessWidget {
  const CardMinhasAssinaturas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        debugPrint("minhas assinaturas foi clicado");
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25),
        child: Card(
          color: Color.fromRGBO(60, 63, 65, 1.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Minha Assinatura",
              style: TextStyle(
                color: Colors.grey
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardMeuPerfil extends StatelessWidget {
  const CardMeuPerfil({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        debugPrint("meu perfil foi clicado");
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const EditProfilePage()),
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25),
        child: Card(
          color: Color.fromRGBO(60, 63, 65, 1.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Meu perfil",
              style: TextStyle(
                  color: Colors.grey
              ),
            ),
          ),
        ),
      ),
    );
  }
}
