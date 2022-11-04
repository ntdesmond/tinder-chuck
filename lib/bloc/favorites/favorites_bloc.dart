import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tinder_chuck/data/models/joke.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(this.favoritesBox) : super(FavoritesInitial()) {
    on<FavoritesLoadEvent>(
      (event, emit) async {
        favoriteJokes.clear();
        favoriteJokes.addAll(favoritesBox.values);
        emit(ShowingFavoritesState());
      },
    );

    on<FavoriteDeleteEvent>(
      (event, emit) async {
        favoriteJokes.remove(event.joke);
        await favoritesBox.delete(event.joke.id);
        emit(FavoriteDeleteNotifyState());
      },
    );

    on<WidgetNotifiedEvent>(
      (event, emit) async {
        emit(ShowingFavoritesState());
      },
    );
  }

  final List<Joke> favoriteJokes = [];
  final Box<Joke> favoritesBox;
}
