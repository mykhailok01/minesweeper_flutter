import 'package:minesweeper_in_flutter/models/cells.dart';
import 'package:minesweeper_in_flutter/models/bomb_plant_advisor.dart';
import 'package:minesweeper_in_flutter/utility.dart';

class FieldLocationInfo {
  final int rows;
  final int columns;
  final int bombs;
  final BombPlantAdvisor _advisor;
  late List<List<int>> _cells;
  bool _tryPlantBomb(int row, int column) {
    if (isBomb(row, column)) return false;
    _cells[row][column] = Cells.bomb;
    return true;
  }

  void _plantBombs() {
    for (int i = 0; i < bombs; ++i) {
      bool planted = false;
      do {
        var position = _advisor.suggestNextPosition();
        planted = _tryPlantBomb(position.row, position.column);
        if (planted) {
          _bombAround(position.row, position.column);
          break;
        }
      } while (true);
    }
  }

  void _bombAround(int row, int column) {
    transformSurrounding(_cells, row, column, (row, column) {
      if (isNotBomb(row, column)) _cells[row][column]++;
    });
  }

  FieldLocationInfo.generate(
      {required this.rows,
      required this.columns,
      required this.bombs,
      required BombPlantAdvisor advisor})
      : _advisor = advisor {
    _cells = List.generate(rows, (_) => List.filled(columns, Cells.empty));
    _plantBombs();
  }

  bool isBomb(int row, int column) => _cells[row][column] == Cells.bomb;
  bool isNotBomb(int row, int column) => !isBomb(row, column);
  int bombsAround(int row, int column) => _cells[row][column];
}
