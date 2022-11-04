import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tinder_chuck/app.dart';
import 'package:tinder_chuck/data/models/joke.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(JokeAdapter());
  final starredJokes = await Hive.openBox('starred');

  runApp(const TinderChuckApp());

  await starredJokes.close();
}
