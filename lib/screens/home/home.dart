import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tinder_chuck/bloc/home/home_screen_bloc.dart';
import 'package:tinder_chuck/data/models/joke.dart';
import 'package:tinder_chuck/data/services/joke_service.dart';
import 'package:tinder_chuck/screens/home/widgets/card_stack.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<Box<Joke>> starredJokes = Hive.openBox('starred');

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: starredJokes,
        builder: (context, snapshot) => snapshot.hasData
            ? BlocProvider<HomeScreenBloc>(
                create: (_) => HomeScreenBloc(
                  JokeService(),
                  snapshot.data!,
                )..add(JokeLoadEvent()),
                child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                  buildWhen: (previous, current) =>
                      previous is HomeStateInitial,
                  builder: (context, state) => Scaffold(
                    appBar: AppBar(
                      title: const Text('Tinder with Chuck Norris'),
                    ),
                    body: const Padding(
                      padding: EdgeInsets.all(30),
                      child: CardStack(stackSize: 5),
                    ),
                  ),
                ),
              )
            : Container(),
      );
}
