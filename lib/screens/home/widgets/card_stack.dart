import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tinder_chuck/bloc/jokes/jokes_bloc.dart';
import 'package:tinder_chuck/data/models/joke.dart';
import 'package:tinder_chuck/screens/home/widgets/joke_card/joke_card.dart';
import 'package:tinder_chuck/data/services/joke_service.dart';

class CardStack extends StatefulWidget {
  const CardStack({super.key, required this.stackSize});

  final int stackSize;

  @override
  State<StatefulWidget> createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  // Allows to keep cards and their states
  List<JokeCard> cards = [];

  final Future<Box<Joke>> starredJokes = Hive.openBox('starred');

  @override
  Widget build(BuildContext context) {
    final loading = Center(
      child: Text(
        'Loading...',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );

    final noNetwork = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.signal_wifi_statusbar_connected_no_internet_4,
            size: 100,
          ),
          Text(
            'Waiting for network...',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );

    return FutureBuilder(
      future: starredJokes,
      builder: (context, snapshot) => snapshot.hasData
          ? BlocProvider<JokesBloc>(
              create: (_) => JokesBloc(
                JokeService(),
                snapshot.data!,
              )..add(JokeLoadEvent()),
              child: BlocBuilder<JokesBloc, JokesState>(
                buildWhen: (previous, current) => previous is JokesStateInitial,
                builder: (context, state) => MultiBlocListener(
                  listeners: [
                    BlocListener<JokesBloc, JokesState>(
                      // Handle network restored event
                      listenWhen: (previous, current) =>
                          previous is NetworkErrorState &&
                          current is! NetworkErrorState,
                      listener: (context, state) {
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Network connection restored'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                      },
                    ),
                    BlocListener<JokesBloc, JokesState>(
                      // Handle network missing event
                      listener: (context, state) {
                        if (state is! NetworkErrorState) {
                          return;
                        }
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Network connection missing'),
                              duration: Duration(minutes: 5),
                            ),
                          );
                      },
                    ),
                    BlocListener<JokesBloc, JokesState>(
                      // Handle clipboard copy event
                      listener: (context, state) {
                        if (state is! JokeCopiedState) {
                          return;
                        }
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text('Joke copied!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        context.read<JokesBloc>().add(WidgetNotifiedEvent());
                      },
                    ),
                    BlocListener<JokesBloc, JokesState>(
                      // Handle browser open failed event (URL == null)
                      listener: (context, state) {
                        if (state is! BrowserOpenErrorState) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Joke URL is empty.'),
                          ),
                        );
                        context.read<JokesBloc>().add(WidgetNotifiedEvent());
                      },
                    ),
                    BlocListener<JokesBloc, JokesState>(
                      // Handle joke loading
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
                                  setState(
                                    () {
                                      cards = [...cards]..removeWhere(
                                          (card) =>
                                              card.joke.id == state.joke.id,
                                        );
                                    },
                                  );
                                  context.read<JokesBloc>().add(
                                        JokeLoadEvent(),
                                      );
                                },
                              ),
                              ...cards,
                            ];
                          },
                        );
                        if (cards.length < widget.stackSize) {
                          context.read<JokesBloc>().add(JokeLoadEvent());
                        }
                      },
                    ),
                  ],
                  child: BlocBuilder<JokesBloc, JokesState>(
                    builder: (context, state) => state is ShowingJokesState
                        ? Stack(children: cards)
                        : state is NetworkErrorState
                            ? noNetwork
                            : loading,
                  ),
                ),
              ),
            )
          : loading,
    );
  }
}
