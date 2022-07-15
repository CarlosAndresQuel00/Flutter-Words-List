import 'package:flutter/material.dart'; // Elements of color, font, etc.
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Hola a todos',
      // Scaffold as matrix or table or grid
      home: Scaffold(
        // Widget elements
        appBar: AppBar(
          title: const Text('Hola a todos'),
        ),
        body: const Center(
          // Random element
          //child: Text(wordPair.asPascalCase),
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    // Create a variable random
    //final wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        //return Text(_suggestions[index].asPascalCase);
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
  }
}