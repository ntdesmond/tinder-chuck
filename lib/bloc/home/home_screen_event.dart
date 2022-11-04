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

class WidgetNotifiedEvent extends HomeScreenEvent {}
