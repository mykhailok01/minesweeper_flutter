import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minesweeper_in_flutter/models/minesweeper_game.dart';
import 'package:minesweeper_in_flutter/widgets/field_tile.dart';
import 'dart:math';

class MinesweeperField extends StatelessWidget {
  const MinesweeperField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var field = context.read<MinesweeperGame>();
        double tileSize = min(constraints.maxHeight / field.rows,
            constraints.maxWidth / field.columns);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: () {
            List<Widget> tilesRows = [];
            for (int row = 0; row < field.rows; ++row) {
              List<Widget> tiles = [];
              for (int column = 0; column < field.columns; ++column) {
                tiles.add(FieldTile(row: row, column: column, size: tileSize));
              }
              tilesRows.add(Row(children: tiles));
            }
            return tilesRows;
          }(),
        );
      },
    );
  }
}
