import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  String image;
  String title;
  TextStyle titleStyle;
  String text;
  TextStyle textStyle;
  String backgroundImage;

  CustomSlider({super.key, required this.image, required this.title, required this.text, required this.backgroundImage, required this.titleStyle, required this.textStyle});

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
            image,
            width: 300,
            height: 250,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}