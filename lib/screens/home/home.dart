import 'package:flutter/material.dart';
import 'package:tinder_chuck/screens/home/widgets/joke_card/joke_card.dart';
import 'package:tinder_chuck/services/joke_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.title});

  final String title;
  final JokeService service = JokeService();

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final int stackLength = 10;
  List<JokeCard> cards = <JokeCard>[];

  void addNewJoke() {
    widget.service.getRandomJoke().then(
          (joke) => setState(
            () {
              var newCard = JokeCard(joke: joke, onNewJokePressed: switchCards);
              cards = [newCard, ...cards];
            },
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < stackLength; i++) {
      addNewJoke();
    }
  }

  void switchCards() {
    // Remove the foremost card (the last one in the list)
    setState(() => cards = [...cards.getRange(0, cards.length - 1)]);

    // Add the new joke to the back of the stack
    addNewJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Stack(children: cards),
      ),
    );
  }
}
