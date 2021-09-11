import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:minesweeper_in_flutter/models/cells.dart';

class MineFieldModel with ChangeNotifier {
  late List<List<int>> _cells;
  MineFieldModel(int rows, int columns)
      : _cells = List.generate(
          rows,
          (_) => List.filled(columns, Cells.closed),
        ) {
    assert(_cells.isNotEmpty);
    assert(_cells.first.isNotEmpty);
  }
  UnmodifiableListView<UnmodifiableListView<int>> get cells =>
      UnmodifiableListView(
        _cells.map(
          (e) => UnmodifiableListView(e),
        ),
      );
  int get rowCount => cells.length;
  int get columnCount => cells.first.length;
}
