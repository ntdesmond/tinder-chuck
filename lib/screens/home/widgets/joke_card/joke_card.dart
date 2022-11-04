import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_chuck/bloc/jokes/jokes_bloc.dart';
import 'package:tinder_chuck/data/models/joke.dart';
import 'package:tinder_chuck/widgets/card_button.dart';
import 'package:tinder_chuck/screens/home/widgets/joke_card/joke_card_image.dart';

// This widget is made stateful to keep the card color and starred state.
class JokeCard extends StatefulWidget {
  const JokeCard({
    required super.key,
    required this.joke,
    required this.isStarred,
    required this.onDismissed,
  });

  final Joke joke;
  final bool isStarred;
  final VoidCallback onDismissed;

  JokeCard starred({required bool isStarred}) => JokeCard(
        key: UniqueKey(),
        joke: joke,
        isStarred: isStarred,
        onDismissed: onDismissed,
      );

  @override
  State<StatefulWidget> createState() => JokeCardState();
}

class JokeCardState extends State<JokeCard> {
  late Color cardColor;
  late Color buttonContentColor;
  late bool isStarred;

  @override
  void initState() {
    super.initState();
    cardColor =
        Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
    buttonContentColor =
        cardColor == Colors.yellow ? Colors.black : Colors.white;
    isStarred = widget.isStarred;
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
                        'Joke ID: ${widget.joke.id}',
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
                        child: Text(widget.joke.value),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (widget.joke.url != null)
                            CardButton(
                              buttonColor: cardColor,
                              buttonContentColor: buttonContentColor,
                              icon: Icons.open_in_browser,
                              onPressed: () => context.read<JokesBloc>().add(
                                    JokeOpenBrowserEvent(widget.joke.url),
                                  ),
                            ),
                          CardButton(
                            buttonColor: cardColor,
                            buttonContentColor: buttonContentColor,
                            icon: isStarred ? Icons.star : Icons.star_border,
                            onPressed: () => context.read<JokesBloc>().add(
                                  JokeStarEvent(widget.joke, isStarred),
                                ),
                          ),
                          CardButton(
                            buttonColor: cardColor,
                            buttonContentColor: buttonContentColor,
                            icon: Icons.copy,
                            onPressed: () => context.read<JokesBloc>().add(
                                  JokeCopyEvent(widget.joke.value),
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

    return BlocListener<JokesBloc, JokesState>(
      listener: (context, state) {
        // Listen for starred state update
        if (state is! JokeStarredState || state.joke != widget.joke) {
          return;
        }
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(
                state.isStarred
                    ? 'Joke added to favorites!'
                    : 'Joke removed from favorites',
              ),
              duration: const Duration(seconds: 1),
            ),
          );

        setState(() => isStarred = state.isStarred);
        context.read<JokesBloc>().add(WidgetNotifiedEvent());
      },
      // Stretch the card and add Dismissible for swipe gestures
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Dismissible(
          key: ObjectKey(card),
          onDismissed: (_) => widget.onDismissed(),
          dismissThresholds: const {DismissDirection.horizontal: 0.2},
          child: card,
        ),
      ),
    );
  }
}
