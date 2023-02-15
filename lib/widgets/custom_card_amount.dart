import 'package:flutter/material.dart';

class CustomCardAmount extends StatelessWidget {
  final double? width;
  final double? height;
  final Color color;

  const CustomCardAmount({super.key, required this.width, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("you balance clicked");
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.white10, spreadRadius: 2, blurRadius: 5, blurStyle: BlurStyle.normal),
          ],
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xfffd5b3e8),
              Color(0xfffe6a5cc),
              Color(0xffffcdbca),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
              child: Column(
                children: [
                  const Text(
                    "Your Balance",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: const [
                      Text(
                        "\$163.88",
                        style: TextStyle(
                            color: Colors.black,
                          fontSize: 50
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/moneyBalance.png',
              width: 75,
              height: 75,
            )
          ],
        ),
      ),
    );
  }
}