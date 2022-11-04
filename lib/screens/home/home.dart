import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_chuck/bloc/home/home_screen_bloc.dart';
import 'package:tinder_chuck/data/services/joke_service.dart';
import 'package:tinder_chuck/screens/home/widgets/card_stack.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<HomeScreenBloc>(
        create: (_) => HomeScreenBloc(JokeService())..add(JokeLoadEvent()),
        child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          buildWhen: (previous, current) => previous is HomeStateInitial,
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
      );
}
