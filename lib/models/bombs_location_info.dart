import 'package:minesweeper_in_flutter/models/cells.dart';
import 'package:minesweeper_in_flutter/utility.dart';
import 'package:minesweeper_in_flutter/models/bomb_plantable.dart';

class BombsLocationInfo implements BombPlantable {
  final int rows;
  final int columns;
  int get bombs => _bombs;
  int _bombs = 0;
  final List<List<CellsInfo>> _cells;

  void _indicateBombAround(int row, int column) {
    transformSurrounding(_cells, row, column, (row, column) {
      if (_isNotBomb(row, column)) _cells[row][column].increment();
    });
  }

  bool _isBomb(int row, int column) => _cells[row][column].val == Cells.bomb;
  bool _isNotBomb(int row, int column) => !_isBomb(row, column);

  BombsLocationInfo.generate({required this.rows, required this.columns})
      : _cells = List.generate(
          rows,
          (_) => List.generate(columns, (_) => CellsInfo(Cells.empty)),
        );

  int getCellInfo(int row, int column) => _cells[row][column].val;
  void removeAllBombs() {
    foreachElement(
        _cells, (row, column) => _cells[row][column] = CellsInfo(Cells.empty));
    _bombs = 0;
  }

  @override
  bool tryPlantBomb(int row, int column) {
    if (_isBomb(row, column)) return false;
    _cells[row][column] = CellsInfo(Cells.bomb);
    _indicateBombAround(row, column);
    ++_bombs;
    return true;
  }
}
