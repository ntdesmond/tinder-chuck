part of 'jokes_bloc.dart';

abstract class JokesEvent {}

class JokeLoadEvent extends JokesEvent {}

class JokeCopyEvent extends JokesEvent {
  JokeCopyEvent(this.text);

  final String text;
}

class JokeOpenBrowserEvent extends JokesEvent {
  JokeOpenBrowserEvent(this.url);

  final String? url;
}

class JokeStarEvent extends JokesEvent {
  JokeStarEvent(this.joke, this.isStarred);

  final Joke joke;
  final bool isStarred;
}

class WidgetNotifiedEvent extends JokesEvent {}
