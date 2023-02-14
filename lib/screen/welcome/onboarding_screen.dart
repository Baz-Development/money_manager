import 'package:flutter/material.dart';
import 'package:money_manager/screen/welcome/welcome_screen.dart';
import 'package:money_manager/widgets/custom_button.dart';
import 'package:money_manager/widgets/custom_link.dart';
import 'package:money_manager/widgets/custom_paginator.dart';
import 'package:money_manager/widgets/custom_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7CD),
      body: SafeArea(
        child: Stack(children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            physics: const ClampingScrollPhysics(),
            children: [
              CustomSlider(
                image: 'assets/onboarding_1.png',
                title: 'Gerenciar suas finanças nunca foi tão fácil',
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(224, 224, 224, 1)
                ),
                text: 'Controle seus investimentos e gastos de forma rápida e fácil,\n além de contar com diversas ferramentas de análise de custos e rendimentos',

                textStyle: const TextStyle(
                    fontSize: 12,
                    color:  Color.fromRGBO(224, 224, 224, 1)
                ),
                backgroundImage: "assets/background_image.png",
              ),
              CustomSlider(
                image: 'assets/onboarding_2.png',
                title: 'Acompanhe e gerencie seu dinheiro\n a qualquer hora, em qualquer lugar e sem complicações',
                titleStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(224, 224, 224, 1)
                ),
                text: 'Apenas com seu celular, é possível acompanhar e gerenciar\n todos seus gastos de uma maneira rápida e eficiente',
                textStyle: const TextStyle(
                    fontSize: 12,
                    color:  Color.fromRGBO(224, 224, 224, 1)
                ),
                backgroundImage: "assets/background_image.png",
              ),
              CustomSlider(
                image: 'assets/onboarding_3.png',
                title: 'Defina objetivos e alcance eles',
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(224, 224, 224, 1)
                ),
                text:
                'Com uso das ferramentas de gerenciamento de gastos e investimentos, é possível criar planos para alcançar suas metas e objetivos de forma fácil e dinâmica',
                textStyle: const TextStyle(
                    fontSize: 12,
                    color:  Color.fromRGBO(224, 224, 224, 1)
                ),
                backgroundImage: "assets/background_image.png",
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  title: 'VOLTAR',
                  irParaPaginaInicial: voltarCard,
                  borderColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  isUserInteractive: _currentPage != 0,
                ),
                CustomButton(
                  title: _currentPage == 2 ? 'QUERO CONHECER' : 'CONTINUAR',
                  irParaPaginaInicial: _currentPage == 2 ? irParaPaginaInicial : proximoCard,
                  borderColor: Colors.deepPurple,
                  backgroundColor: Colors.blueAccent,
                  isUserInteractive: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLink(
                  titulo: 'Pular introdução',
                  irParaPaginaInicial: irParaPaginaInicial,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 170.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaginator(
                  page: _currentPage,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void irParaPaginaInicial() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));

    _setEstado();
  }

  void proximoCard() {
    _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

  void voltarCard() {
    _pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

  _setEstado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool ativo = prefs.getBool('ONBOARDING') ?? false;

    if (!ativo) {
      await prefs.setBool('ONBOARDING', true);
    }
  }
}