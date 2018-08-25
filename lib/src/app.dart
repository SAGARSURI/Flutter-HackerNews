import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoriesProvider(
      child: MaterialApp(
        home: NewsList(),
      ),
    );
  }
}
