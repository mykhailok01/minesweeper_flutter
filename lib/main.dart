import 'package:flutter/material.dart';
import 'package:minesweeper_in_flutter/data/records_manager.dart';
import 'package:provider/provider.dart';
import 'package:minesweeper_in_flutter/widgets/game_page.dart';
import 'package:minesweeper_in_flutter/models/minesweeper_game.dart';
import 'package:minesweeper_in_flutter/data/records_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RecordManager recordManager = await RecordManager.create();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              MinesweeperGame(rows: 9, columns: 9, bombs: 10),
        ),
        FutureProvider<List<Record>>(
          initialData: [],
          create: (BuildContext context) => recordManager.getRecords(),
        ),
      ],
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minesweeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(),
    );
  }
}
