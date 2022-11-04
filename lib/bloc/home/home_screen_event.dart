part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent {}

class JokeLoadEvent extends HomeScreenEvent {}

class JokeCopyEvent extends HomeScreenEvent {
  JokeCopyEvent(this.text);

  final String text;
}

class JokeOpenBrowserEvent extends HomeScreenEvent {
  JokeOpenBrowserEvent(this.url);

  final String? url;
}

class JokeStarEvent extends HomeScreenEvent {
  JokeStarEvent(this.joke, this.isStarred);

  final Joke joke;
  final bool isStarred;
}

class WidgetNotifiedEvent extends HomeScreenEvent {}
