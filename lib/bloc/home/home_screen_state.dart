part of 'home_screen_bloc.dart';

abstract class HomeScreenState {
  const HomeScreenState();
}

class HomeStateInitial extends HomeScreenState {}

class ShowingJokesState extends HomeScreenState {}

class JokeLoadedState extends ShowingJokesState {
  JokeLoadedState(this.joke);

  final Joke joke;
}

class BrowserOpenErrorState extends ShowingJokesState {}

class JokeCopiedState extends ShowingJokesState {}
