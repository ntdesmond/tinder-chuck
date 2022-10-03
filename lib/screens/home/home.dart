import 'package:flutter/material.dart';
import 'package:tinder_chuck/models/joke.dart';
import 'package:tinder_chuck/screens/home/widgets/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String joke = "joke text";

  void showNewJoke() {
    setState(() => joke = "some funny joke here");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: JokeCard(
          joke: Joke(id: 'epofkoppolflp[ds', value: 'joke text lol'),
          onNewJokePressed: showNewJoke,
        ),
      ),
    );
  }
}
