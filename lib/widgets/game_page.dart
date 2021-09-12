import 'package:flutter/material.dart';
import 'package:minesweeper_in_flutter/widgets/minesweeper_field.dart';
import 'package:minesweeper_in_flutter/widgets/game_appbar.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: GameAppBar(),
        body: Center(
          child: MinesweeperField(),
        ),
      ),
    );
  }
}
