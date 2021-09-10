import 'package:flutter/material.dart';
import 'package:minesweeper_in_flutter/widgets/game_page.dart';
import 'package:provider/provider.dart';
import 'package:minesweeper_in_flutter/models/mine_field_model.dart';
import 'package:minesweeper_in_flutter/widgets/game_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MineFieldModel(10, 10),
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
