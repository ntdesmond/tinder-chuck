part of 'jokes_bloc.dart';

abstract class JokesState {
  const JokesState();
}

class JokesStateInitial extends JokesState {}

class NetworkErrorState extends JokesState {}

class ShowingJokesState extends JokesState {}

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
