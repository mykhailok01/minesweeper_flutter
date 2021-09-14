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
          (_) => List.generate(
              locationInfo.columns, (_) => CellsStatus(Cells.closed)),
        ) {
    assert(_cellsStatuses.isNotEmpty);
    assert(_cellsStatuses.first.isNotEmpty);
  }

  int discloseCellInfo(int row, int column) {
    int discloseCount = 0;
    void _discloseCellInfo(int row, int column) {
      if (row < 0 || row >= rows) return;
      if (column < 0 || column >= columns) return;
      if (_cellsStatuses[row][column].val != Cells.closed) return;
      _cellsStatuses[row][column] =
          CellsStatus(locationInfo.getCellInfo(row, column));
      ++discloseCount;
      if (_cellsStatuses[row][column].val == Cells.empty) {
        transformSurrounding(_cellsStatuses, row, column, _discloseCellInfo);
      }
    }

    _discloseCellInfo(row, column);
    if (_cellsStatuses[row][column].val == Cells.bomb)
      _cellsStatuses[row][column] = CellsStatus(Cells.justOpenedBomb);
    return discloseCount;
  }

  void resetStatuses() => foreachElement(_cellsStatuses,
      (row, column) => _cellsStatuses[row][column] = CellsStatus(Cells.closed));

  int cellStatus(int row, int column) => _cellsStatuses[row][column].val;

  int get cellsCount => rows * columns;

  int _count(bool Function(CellsStatus) condition) {
    int count = 0;
    for (List<CellsStatus> rowElements in _cellsStatuses)
      for (CellsStatus status in rowElements) if (condition(status)) ++count;
    return count;
  }

  int get closedCount {
    return _count((status) => status.val == Cells.closed);
  }

  int get disclosedCount {
    return cellsCount - closedCount;
  }

  int get disclosedBombCount {
    return _count(
      (status) =>
          status.val == Cells.bomb || status.val == Cells.justOpenedBomb,
    );
  }

  late List<List<CellsStatus>> _cellsStatuses;
}
