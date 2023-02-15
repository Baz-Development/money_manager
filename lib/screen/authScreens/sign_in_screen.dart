import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/common/theme_helper.dart';
import 'package:money_manager/exceptions/FirebaseCustomException.dart';
import 'package:money_manager/screen/authScreens/forget_password_screen.dart';
import 'package:money_manager/screen/home/home_screen.dart';
import 'package:money_manager/screen/authScreens/sign_up_screen.dart';
import 'package:money_manager/services/firebase_auth_service.dart';
import 'package:money_manager/widgets/header_widget.dart';

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
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                  child: Column(
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const Text(
                        'Signin into your account',
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
                                decoration: ThemeHelper().textInputDecoration('Email', 'Enter your email'),
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Container(
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
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
                                child: const Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Sign In'.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
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
                                      text: "Don't have an account?",
                                      style: TextStyle(
                                        color: Colors.grey
                                      )
                                    ),
                                    TextSpan(
                                      text: ' Create',
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
      await getUser(userId);
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