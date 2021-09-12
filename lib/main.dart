import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minesweeper_in_flutter/widgets/game_page.dart';
import 'package:minesweeper_in_flutter/models/minesweeper_game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MinesweeperGame(rows: 9, columns: 9, bombs: 10),
      child: MaterialApp(
        title: 'Minesweeper',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GamePage(),
      ),
    );
  }
}
