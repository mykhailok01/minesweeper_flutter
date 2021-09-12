import 'package:minesweeper_in_flutter/models/mines_location_info.dart';
import 'package:minesweeper_in_flutter/models/cells.dart';
import 'package:minesweeper_in_flutter/utility.dart';

class CellsStatusManager {
  int get rows => info.rows;
  int get columns => info.columns;
  final MinesLocationInfo info;
  CellsStatusManager({required this.info})
      : _cellsStatuses = List.generate(
          info.rows,
          (_) => List.filled(info.columns, Cells.closed),
        ) {
    assert(_cellsStatuses.isNotEmpty);
    assert(_cellsStatuses.first.isNotEmpty);
  }

  int discloseCellInfo(int row, int column) {
    int discloseCount = 0;
    void _discloseCellInfo(int row, int column) {
      if (row < 0 || row >= rows) return;
      if (column < 0 || column >= columns) return;
      if (_cellsStatuses[row][column] != Cells.closed) return;
      _cellsStatuses[row][column] = info.getCellInfo(row, column);
      ++discloseCount;
      if (_cellsStatuses[row][column] == Cells.empty) {
        transformSurrounding(_cellsStatuses, row, column, _discloseCellInfo);
      }
    }

    _discloseCellInfo(row, column);
    return discloseCount;
  }

  int cellStatus(int row, int column) => _cellsStatuses[row][column];

  int get cellsCount => rows * columns;

  int _count(bool Function(int) condition) {
    int count = 0;
    for (List<int> rowElements in _cellsStatuses)
      for (int status in rowElements) if (condition(status)) ++count;
    return count;
  }

  int get closedCount {
    return _count((status) => status == Cells.closed);
  }

  int get disclosedCount {
    return cellsCount - closedCount;
  }

  int get disclosedBombCount {
    return _count((status) => status == Cells.bomb);
  }

  late List<List<int>> _cellsStatuses;
}
