part of 'home_screen_bloc.dart';

abstract class HomeScreenState {
  const HomeScreenState();
}

class HomeStateInitial extends HomeScreenState {}

class ShowingJokesState extends HomeScreenState {}

class JokeLoadedState extends ShowingJokesState {
  JokeLoadedState({required this.joke, required this.isStarred});

  final Joke joke;
  final bool isStarred;
}

class BrowserOpenErrorState extends ShowingJokesState {}

class JokeStarredState extends ShowingJokesState {
  JokeStarredState(this.joke, this.isStarred);

  final Joke joke;
  final bool isStarred;
}

class JokeCopiedState extends ShowingJokesState {}
