part of 'favorites_bloc.dart';

abstract class FavoritesEvent {}

class FavoritesLoadEvent extends FavoritesEvent {}

class FavoriteDeleteEvent extends FavoritesEvent {
  FavoriteDeleteEvent(this.joke);

  final Joke joke;
}

class WidgetNotifiedEvent extends FavoritesEvent {}
