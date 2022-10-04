import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tinder_chuck/models/joke.dart';
import 'package:tinder_chuck/screens/home/widgets/joke_card/joke_card_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JokeCard extends StatelessWidget {
  JokeCard({super.key, required this.joke, required this.onNewJokePressed});

  final VoidCallback onNewJokePressed;
  final Joke joke;

  final Color cardColor =
      Colors.primaries[math.Random().nextInt(Colors.primaries.length)];

  void openBrowser() {
    if (joke.url == null) {
      return;
    }

    launchUrlString(joke.url!, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              JokeCardImage(
                  bgColor: cardColor,
                  image: const Image(
                    image: AssetImage('./assets/images/chucknorris.png'),
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Joke ID: ${joke.id}",
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                      Text(
                        "Joke for you!",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(joke.value),
                        ),
                      ),
                      if (joke.url != null)
                        OutlinedButton(
                          onPressed: openBrowser,
                          child: const Text("Open in browser"),
                        ),
                      ElevatedButton(
                        onPressed: onNewJokePressed,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: cardColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            textStyle: Theme.of(context).textTheme.headline6),
                        child: const Text("New joke"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
