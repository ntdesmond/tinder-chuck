import 'package:flutter/material.dart';

class JokeCardImage extends StatelessWidget {
  const JokeCardImage({super.key, required this.bgColor, required this.image});

  final Color bgColor;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        color: bgColor,
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Image(image: AssetImage("assets/images/chucknorris.png")),
        ),
      ),
    );
  }
}
