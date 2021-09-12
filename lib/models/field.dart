import 'dart:collection';
import 'package:minesweeper_in_flutter/models/field_location_info.dart';
import 'package:minesweeper_in_flutter/models/cells.dart';
import 'package:minesweeper_in_flutter/utility.dart';

class Field {
  final int rows;
  final int columns;
  final FieldLocationInfo info;
  late List<List<int>> _cellsStatuses;
  Field({required this.rows, required this.columns, required this.info})
      : _cellsStatuses = List.generate(
          rows,
          (_) => List.filled(columns, Cells.closed),
        ) {
    assert(_cellsStatuses.isNotEmpty);
    assert(_cellsStatuses.first.isNotEmpty);
  }

  bool openCell(int row, int column) {
    if (row < 0 || row >= rows) return false;
    if (column < 0 || column >= columns) return false;
    if (_cellsStatuses[row][column] != Cells.closed) return false;
    _cellsStatuses[row][column] = info.bombsAround(row, column);
    if (_cellsStatuses[row][column] == Cells.empty) {
      transformSurrounding(cells, row, column, openCell);
    }
    return true;
  }

  int cellStatus(int row, int column) => _cellsStatuses[row][column];

  UnmodifiableListView<UnmodifiableListView<int>> get cells =>
      UnmodifiableListView(
        _cellsStatuses.map(
          (e) => UnmodifiableListView(e),
        ),
      );
}
