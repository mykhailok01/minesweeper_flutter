import 'package:flutter/material.dart';
import 'package:minesweeper_in_flutter/models/cells.dart';
import 'package:minesweeper_in_flutter/models/minesweeper_game.dart';
import 'package:provider/provider.dart';

class FieldTile extends StatelessWidget {
  final int row;
  final int column;
  final double size;
  const FieldTile(
      {Key? key, required this.row, required this.column, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var field = context.watch<MinesweeperGame>();
    var value = field.cellInfo(row, column);
    return GestureDetector(
      onTap: () => field.discloseCell(row, column),
      child: Container(
        color: () {
          if (value == Cells.closed)
            return Colors.lightBlue.shade300;
          else if (value == Cells.justOpenedBomb)
            return Colors.redAccent.shade100;
          return Colors.lightBlue.shade50;
        }(),
        margin: const EdgeInsets.all(1),
        width: size - 2,
        height: size - 2,
        child: Builder(builder: (_) {
          switch (value) {
            case Cells.bomb:
            case Cells.justOpenedBomb:
              return Icon(Icons.settings);
            case Cells.empty:
            case Cells.closed:
              return Container();
          }
          return Text('$value');
        }),
      ),
    );
  }
}
