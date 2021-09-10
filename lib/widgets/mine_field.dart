import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minesweeper_in_flutter/models/mine_field_model.dart';
import 'package:minesweeper_in_flutter/widgets/mine_cell.dart';

class MineField extends StatelessWidget {
  const MineField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MineFieldModel>(
      builder: (_, field, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: field.cells
              .map(
                (rowCells) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: rowCells
                      .map(
                        (value) => MineCell(value: value),
                      )
                      .toList(),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
