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
                imagem: 'assets/onboarding_1.png',
                titulo: 'Sua Comida favorita',
                texto: 'Almoço, janta, cafézinho da manhã ou da tarde. A qual quer horário para atendimento.',
                backgroundImage: "assets/background_image.png",
              ),
              CustomSlider(
                imagem: 'assets/onboarding_2.png',
                titulo: 'Você recebe no conforto de onde estiver',
                texto: 'Seu pedido é atendido pelo restaurante mais próximo, que leva tudo pra você.',
                backgroundImage: "assets/background_image.png",
              ),
              CustomSlider(
                imagem: 'assets/onboarding_3.png',
                titulo: 'Melhores Chef’s',
                texto:
                'Chefs, dos quais a maioria vem de restaurantes com estrelas Michelin ou são vencedores de competições de prestígio e títulos.',
                backgroundImage: "assets/background_image.png",
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  titulo: _currentPage == 2 ? 'QUERO CONHECER' : 'CONTINUAR',
                  irParaPaginaInicial: _currentPage == 2 ? irParaPaginaInicial : proximoCard,
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

  _setEstado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool ativo = prefs.getBool('ONBOARDING') ?? false;

    if (!ativo) {
      await prefs.setBool('ONBOARDING', true);
    }
  }
}