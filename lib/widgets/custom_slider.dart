import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  String imagem;
  String titulo;
  String texto;
  String backgroundImage;

  CustomSlider({super.key, required this.imagem, required this.titulo, required this.texto, required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          Image.asset(
            imagem,
            width: 300,
            height: 250,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  titulo,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(224, 224, 224, 1)
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Text(
              texto,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  color:  Color.fromRGBO(224, 224, 224, 1)
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}