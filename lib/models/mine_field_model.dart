import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:minesweeper_in_flutter/models/field.dart';
import 'package:minesweeper_in_flutter/models/field_location_info.dart';
import 'package:minesweeper_in_flutter/models/random_bomb_plan_advisor.dart';

class MineFieldModel with ChangeNotifier {
  Field field;
  MineFieldModel({
    required int rows,
    required int columns,
  }) : field = Field(
            rows: rows,
            columns: columns,
            info: FieldLocationInfo.generate(
                rows: rows,
                columns: columns,
                bombs: 10,
                advisor: RandomBombPlantAdvisor(columns: columns, rows: rows)));
  UnmodifiableListView<UnmodifiableListView<int>> get cells => field.cells;
  int get rows => field.rows;
  int get columns => field.columns;
  int cell(int row, int column) => field.cellStatus(row, column);
  void openCell(int row, int column) {
    field.openCell(row, column);
    notifyListeners();
  }
}
