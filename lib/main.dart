import 'package:flutter/material.dart'; // Elements of color, font, etc.
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Hola a todos',
      // Scaffold as matrix or table or grid
      /*
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
      */
      //home: RandomWords(),
      theme: ThemeData(          // Add the 5 lines from here... 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),                         // ... to here.
      home: const RandomWords(), // And add the const back here.
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
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    // Create a variable random
    //final wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);
    /*
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        final alreadySaved = _saved.contains(_suggestions[index]);
        //return Text(_suggestions[index].asPascalCase);
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
          trailing: Icon(    // NEW from here ...
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
          ),
          onTap: () {          // NEW from here ...
            setState(() {
              if (alreadySaved) {
                _saved.remove(_suggestions[index]);
              } else {
                _saved.add(_suggestions[index]);
              }
            });                // to here.
          },
        );
      },
    );
    */
    return Scaffold(   // NEW from here ...
      appBar: AppBar(  
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),               
      body: ListView.builder(  // to here.
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          final alreadySaved = _saved.contains(_suggestions[index]);
          //return Text(_suggestions[index].asPascalCase);
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(    // NEW from here ...
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {          // NEW from here ...
              setState(() {
                if (alreadySaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });                // to here.
            },
          );
        },
      ),                       // NEW
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}