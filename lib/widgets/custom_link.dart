import 'package:flutter/material.dart';

class CustomLink extends StatelessWidget {
  final String titulo;
  final void Function() irParaPaginaInicial;

  const CustomLink({required this.titulo, required this.irParaPaginaInicial});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: irParaPaginaInicial,
          child: RichText(
            text: TextSpan(
              text: titulo,
              style: const TextStyle(
                  color: Color.fromRGBO(224, 224, 224, 1)
              ),
            ),
          ),
        ),
      ],
    );
  }
}