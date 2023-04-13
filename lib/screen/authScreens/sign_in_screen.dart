import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/common/shared_preferences.dart';
import 'package:money_manager/common/theme_helper.dart';
import 'package:money_manager/exceptions/FirebaseCustomException.dart';
import 'package:money_manager/models/user_model.dart';
import 'package:money_manager/screen/authScreens/forget_password_screen.dart';
import 'package:money_manager/screen/home/home_screen.dart';
import 'package:money_manager/screen/authScreens/sign_up_screen.dart';
import 'package:money_manager/services/firebase_auth_service.dart';
import 'package:money_manager/widgets/header_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/firebase_user_repository.dart';

class SignInScreen extends StatefulWidget{
  const SignInScreen({Key? key}): super(key:key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>{
  final double _headerHeight = 250;
  final Key _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 20, 29, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, "assets/splash.png", true, onTap: () {
                Navigator.pop(context);
              }), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),// This wiLogin into your accountll be the login form
                  child: Column(
                    children: [
                      const Text(
                        'olá',
                        style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const Text(
                        'Entre na sua conta',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextField(
                                controller: emailController,
                                decoration: ThemeHelper().textInputDecoration('Email', 'Insira o email'),
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Container(
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration('Senha', 'Insira a senha'),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10,0,10,20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  debugPrint("forget password");
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()));
                                },
                                child: const Text( "Esqueceu sua senha?", style: TextStyle( color: Colors.grey, ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(40, 25, 40, 10),
                                  child: Text('Entrar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: (){
                                  var email = emailController.text;
                                  var password = passwordController.text;
                                  signInWithFirebaseBaseEmail(email, password);
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Não tem uma conta?",
                                      style: TextStyle(
                                        color: Colors.grey
                                      )
                                    ),
                                    TextSpan(
                                      text: 'Cadastrar',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                                  ),
                                ]
                              )
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signInWithFirebaseBaseEmail(String email, String password) async {
    if(email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog("Dados invalídos", "Informe o email e senha para realizar o login.", context);
        },
      );
      return;
    }
    try {
      var userId = await signInFirebaseEmail(email, password);
      if( userId == null) {
        return;
      }
      UserModel user = await getUser(userId);

      SharedPref sharedPref = SharedPref();
      await sharedPref.save("user", user);

      debugPrint("user logged");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const HomeScreen()
          ),
              (Route<dynamic> route) => false
      );
    } on FirebaseCustomException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog("Ops", e.cause, context);
        },
      );
    }

  }
}