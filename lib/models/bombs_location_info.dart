import 'package:minesweeper_in_flutter/models/cells.dart';
import 'package:minesweeper_in_flutter/utility.dart';
import 'package:minesweeper_in_flutter/models/bomb_plantable.dart';

class BombsLocationInfo implements BombPlantable {
  final int rows;
  final int columns;
  int get bombs => _bombs;
  int _bombs = 0;
  final List<List<int>> _cells;

  void _indicateBombAround(int row, int column) {
    transformSurrounding(_cells, row, column, (row, column) {
      if (isNotBomb(row, column)) _cells[row][column]++;
    });
  }

  BombsLocationInfo.generate({required this.rows, required this.columns})
      : _cells = List.generate(
          rows,
          (_) => List.filled(columns, Cells.empty),
        );

  bool isBomb(int row, int column) => _cells[row][column] == Cells.bomb;
  bool isNotBomb(int row, int column) => !isBomb(row, column);
  int getCellInfo(int row, int column) => _cells[row][column];
  void removeAllBombs() {
    foreachElement(_cells, (row, column) => _cells[row][column] = Cells.empty);
    _bombs = 0;
  }

  @override
  bool tryPlantBomb(int row, int column) {
    if (isBomb(row, column)) return false;
    _cells[row][column] = Cells.bomb;
    _indicateBombAround(row, column);
    ++_bombs;
    return true;
  }
}
