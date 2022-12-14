import 'package:dio/dio.dart';

import 'package:tinder_chuck/data/models/joke.dart';

class JokeServiceException implements Exception {}

class JokeService {
  JokeService({this.apiRoot = 'https://api.chucknorris.io/'})
      : client = Dio(BaseOptions(baseUrl: apiRoot));

  final String apiRoot;
  final Dio client;

  Future<Joke> getRandomJoke() async {
    try {
      var response = await client.get('/jokes/random');
      return Joke.fromJson(response.data);
    } on DioError {
      throw JokeServiceException();
    }
  }
}
