import 'package:flutter/material.dart';
import 'package:tinder_chuck/screens/home.dart';

class TinderChuckApp extends StatelessWidget {
  const TinderChuckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinder Chuck',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(title: 'Tinder with Chuck Norris'),
    );
  }
}