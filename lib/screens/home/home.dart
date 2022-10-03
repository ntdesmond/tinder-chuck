import 'package:flutter/material.dart';
import 'package:tinder_chuck/models/joke.dart';
import 'package:tinder_chuck/screens/home/widgets/card.dart';
import 'package:tinder_chuck/services/joke_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.title});

  final String title;
  final JokeService service = JokeService();

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Joke joke = Joke(id: '-', value: 'Loading...');

  @override
  void initState() {
    super.initState();
    showNewJoke();
  }

  void openBrowser() {
    if (joke.url == null) {
      return;
    }

    launchUrlString(joke.url!, mode: LaunchMode.externalApplication);
  }

  void showNewJoke() {
    widget.service
        .getRandomJoke()
        .then((value) => setState(() => joke = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: JokeCard(
          joke: joke,
          onNewJokePressed: showNewJoke,
          onOpenBrowserPressed: openBrowser,
        ),
      ),
    );
  }
}
