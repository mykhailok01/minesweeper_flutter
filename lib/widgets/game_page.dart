import 'package:flutter/material.dart';
import 'package:minesweeper_in_flutter/widgets/mine_tile_field.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: MineTileField(),
        ),
      ),
    );
  }
}
