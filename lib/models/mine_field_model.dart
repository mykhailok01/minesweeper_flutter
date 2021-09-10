import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:minesweeper_in_flutter/models/cells.dart';

class MineFieldModel with ChangeNotifier {
  late List<List<int>> _cells;
  MineFieldModel(int rows, int columns)
      : _cells = List.filled(
          rows,
          List.filled(columns, Cells.empty),
        );
  UnmodifiableListView<UnmodifiableListView<int>> get cells =>
      UnmodifiableListView(
        _cells.map(
          (e) => UnmodifiableListView(e),
        ),
      );
}
