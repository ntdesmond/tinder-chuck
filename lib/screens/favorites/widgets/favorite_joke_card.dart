import 'package:flutter/material.dart';
import 'package:tinder_chuck/data/models/joke.dart';
import 'package:tinder_chuck/widgets/card_button.dart';

class FavoriteJokeCard extends StatelessWidget {
  const FavoriteJokeCard({
    super.key,
    required this.joke,
    required this.onDelete,
  });

  final Joke joke;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Joke ID: ${joke.id}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 10),
                    Text(joke.value),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              CardButton(
                  onPressed: onDelete,
                  buttonColor: Colors.red,
                  buttonContentColor: Colors.white,
                  icon: Icons.delete)
            ],
          ),
        ),
      );
}
