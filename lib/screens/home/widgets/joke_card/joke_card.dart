import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tinder_chuck/models/joke.dart';
import 'package:tinder_chuck/screens/home/widgets/joke_card/joke_card_image.dart';
import 'package:tinder_chuck/services/joke_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

typedef JokeCardDismissCallback = void Function(JokeCard);

// This widget is made stateful to handle swipe gesture properly.
class JokeCard extends StatefulWidget {
  const JokeCard({
    super.key,
    required this.service,
    required this.onDismissed,
  });

  final JokeCardDismissCallback onDismissed;
  final JokeService service;

  @override
  State<StatefulWidget> createState() => JokeCardState();
}

class JokeCardState extends State<JokeCard> {
  Joke joke = Joke(id: '', value: 'Loading...');
  final Color cardColor =
      Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
  late final Color buttonContentColor;

  @override
  void initState() {
    super.initState();
    buttonContentColor =
        cardColor == Colors.yellow ? Colors.black : Colors.white;
    widget.service.getRandomJoke().then(
          (joke) => setState(() => this.joke = joke),
        );
  }

  void openBrowser() {
    if (joke.url == null) {
      return;
    }

    launchUrlString(joke.url!, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    var card = Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            JokeCardImage(
              bgColor: cardColor,
              image: const Image(
                image: AssetImage('./assets/images/chucknorris.png'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Joke ID: ${joke.id}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      'Joke for you!',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(joke.value),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (joke.url != null)
                            Ink(
                              decoration: ShapeDecoration(
                                color: cardColor,
                                shape: const CircleBorder(),
                              ),
                              child: IconButton(
                                onPressed: openBrowser,
                                icon: Icon(
                                  Icons.open_in_browser,
                                  color: buttonContentColor,
                                ),
                              ),
                            ),
                          Ink(
                            decoration: ShapeDecoration(
                              color: cardColor,
                              shape: const CircleBorder(),
                            ),
                            child: IconButton(
                              onPressed: () => Clipboard.setData(
                                ClipboardData(text: joke.value),
                              ).then(
                                (value) => ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text('Joke copied!'),
                                  ),
                                ),
                              ),
                              icon: Icon(
                                Icons.copy,
                                color: buttonContentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text('👈 Swipe to get a new joke 👉'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Stretch the card and add Dismissible for swipe gestures
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Dismissible(
        key: ObjectKey(card),
        onDismissed: (_) => widget.onDismissed(widget),
        child: card,
      ),
    );
  }
}
