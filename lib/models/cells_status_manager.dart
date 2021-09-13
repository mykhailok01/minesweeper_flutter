import 'package:minesweeper_in_flutter/models/bombs_location_info.dart';
import 'package:minesweeper_in_flutter/models/cells.dart';
import 'package:minesweeper_in_flutter/utility.dart';

class CellsStatusManager {
  int get rows => locationInfo.rows;
  int get columns => locationInfo.columns;
  final BombsLocationInfo locationInfo;
  CellsStatusManager({required this.locationInfo})
      : _cellsStatuses = List.generate(
          locationInfo.rows,
          (_) => List.filled(locationInfo.columns, Cells.closed),
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
      _cellsStatuses[row][column] = locationInfo.getCellInfo(row, column);
      ++discloseCount;
      if (_cellsStatuses[row][column] == Cells.empty) {
        transformSurrounding(_cellsStatuses, row, column, _discloseCellInfo);
      }
    }

    _discloseCellInfo(row, column);
    if (_cellsStatuses[row][column] == Cells.bomb)
      _cellsStatuses[row][column] = Cells.justOpenedBomb;
    return discloseCount;
  }

  void resetStatuses() => foreachElement(_cellsStatuses,
      (row, column) => _cellsStatuses[row][column] = Cells.closed);

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
    return _count(
      (status) => status == Cells.bomb || status == Cells.justOpenedBomb,
    );
  }

  late List<List<int>> _cellsStatuses;
}
