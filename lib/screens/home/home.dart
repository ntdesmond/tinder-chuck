import 'package:flutter/material.dart';
import 'package:tinder_chuck/screens/home/widgets/joke_card/joke_card.dart';
import 'package:tinder_chuck/services/joke_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final int stackLength = 5;
  List<JokeCard> cards = <JokeCard>[];

  final JokeService service = JokeService();

  void addNewJoke() {
    var newCard = JokeCard(
      key: UniqueKey(),
      service: service,
      onDismissed: switchCards,
    );
    cards = [newCard, ...cards];
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < stackLength; i++) {
      addNewJoke();
    }
  }

  void switchCards(JokeCard dismissedCard) {
    setState(() => cards.remove(dismissedCard));
    addNewJoke();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Stack(
            children: cards,
          ),
        ),
      );
}
