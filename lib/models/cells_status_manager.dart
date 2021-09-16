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
    void _discloseCellInfo(
        int row, int column, List<List<CellsStatus>> cellsStatuses) {
      if (row < 0 || row >= rows) return;
      if (column < 0 || column >= columns) return;
      if (cellsStatuses[row][column].val != Cells.closed) return;
      cellsStatuses[row][column] =
          CellsStatus(locationInfo.getCellInfo(row, column));
      ++discloseCount;
      if (cellsStatuses[row][column].val == Cells.empty) {
        transformSurrounding(cellsStatuses, row, column,
            (row, column) => _discloseCellInfo(row, column, cellsStatuses));
      }
    }

    _discloseCellInfo(row, column, _cellsStatuses);
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

  int get disclosedBombCount {
    return _count(
      (status) =>
          status.val == Cells.bomb || status.val == Cells.justOpenedBomb,
    );
  }

  late List<List<CellsStatus>> _cellsStatuses;
}
