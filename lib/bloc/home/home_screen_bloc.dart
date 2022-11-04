import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_chuck/data/models/joke.dart';
import 'package:tinder_chuck/data/services/joke_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc(this.service) : super(HomeStateInitial()) {
    on<JokeLoadEvent>(
      (event, emit) async {
        emit(JokeLoadedState(await service.getRandomJoke()));
      },
    );

    on<JokeCopyEvent>(
      (event, emit) async {
        await Clipboard.setData(
          ClipboardData(text: event.text),
        );
        emit(JokeCopiedState());
      },
    );

    on<JokeOpenBrowserEvent>(
      (event, emit) async {
        if (event.url == null) {
          emit(BrowserOpenErrorState());
        }

        unawaited(
          launchUrlString(
            event.url!,
            mode: LaunchMode.externalApplication,
          ),
        );
      },
    );

    on<WidgetNotifiedEvent>(
      (event, emit) async {
        emit(ShowingJokesState());
      },
    );
  }

  final JokeService service;
}
