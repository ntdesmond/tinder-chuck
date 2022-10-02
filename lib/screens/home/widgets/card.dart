import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class JokeCard extends StatelessWidget {
  const JokeCard(
      {super.key, required this.joke, required this.onNewJokePressed});

  final String joke;
  final VoidCallback onNewJokePressed;

  @override
  Widget build(BuildContext context) {
    final cardColor =
        Colors.primaries[math.Random().nextInt(Colors.primaries.length)];

    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: cardColor,
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Image(
                        image: AssetImage("assets/images/chucknorris.png")),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Joke for you!",
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 20),
              Text(joke),
              const Spacer(),
              ElevatedButton(
                onPressed: onNewJokePressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: cardColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: Theme.of(context).textTheme.headline6),
                child: const Text("New joke"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
