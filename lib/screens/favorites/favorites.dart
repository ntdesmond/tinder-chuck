import 'package:flutter/material.dart';
import 'package:tinder_chuck/screens/favorites/widgets/favorites_list.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Favorite jokes'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(10),
            child: FavoritesList(),
          ),
        ),
      );
}
