import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String titulo;
  final void Function() irParaPaginaInicial;

  const CustomButton({required this.titulo, required this.irParaPaginaInicial});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 50,
          width: 300,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0XFFFD5523)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(color: Colors.orange)))),
            onPressed: () {
              irParaPaginaInicial();
            },
            child: Text(
              titulo,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        )
      ],
    );
  }
}