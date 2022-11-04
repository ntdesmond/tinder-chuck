import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_chuck/bloc/home/home_screen_bloc.dart';
import 'package:tinder_chuck/screens/home/widgets/joke_card/joke_card.dart';

class CardStack extends StatefulWidget {
  const CardStack({super.key, required this.stackSize});

  final int stackSize;

  @override
  State<StatefulWidget> createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  // Allows to keep cards and their colors
  List<JokeCard> cards = [];

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<HomeScreenBloc, HomeScreenState>(
            listener: (context, state) {
              if (state is! JokeCopiedState) {
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Joke copied!'),
                  duration: Duration(seconds: 1),
                ),
              );
              context.read<HomeScreenBloc>().add(WidgetNotifiedEvent());
            },
          ),
          BlocListener<HomeScreenBloc, HomeScreenState>(
            listener: (context, state) {
              if (state is! BrowserOpenErrorState) {
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Joke URL is empty.'),
                ),
              );
              context.read<HomeScreenBloc>().add(WidgetNotifiedEvent());
            },
          ),
          BlocListener<HomeScreenBloc, HomeScreenState>(
            listener: (context, state) {
              if (state is! JokeLoadedState) {
                return;
              }
              setState(
                () {
                  cards = [
                    JokeCard(
                      key: UniqueKey(),
                      joke: state.joke,
                      isStarred: state.isStarred,
                      onDismissed: () {
                        setState(() {
                          cards = [...cards]..removeWhere(
                              (card) => card.joke.id == state.joke.id,
                            );
                        });
                        context.read<HomeScreenBloc>().add(
                              JokeLoadEvent(),
                            );
                      },
                    ),
                    ...cards,
                  ];
                },
              );
              if (cards.length < widget.stackSize) {
                context.read<HomeScreenBloc>().add(JokeLoadEvent());
              }
            },
          ),
        ],
        child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) => state is ShowingJokesState
              ? Stack(children: cards)
              : Center(
                  child: Text(
                    'Loading...',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
        ),
      );
}
