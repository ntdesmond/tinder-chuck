import 'package:flutter/material.dart';
import 'package:tinder_chuck/screens/home/home.dart';

class TinderChuckApp extends StatelessWidget {
  const TinderChuckApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Tinder Chuck',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const HomeScreen(),
      );
}
