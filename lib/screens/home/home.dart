import 'package:flutter/material.dart';
import 'package:tinder_chuck/screens/home/widgets/card_stack.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Tinder with Chuck Norris'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(30),
          child: CardStack(stackSize: 5),
        ),
      );
}
