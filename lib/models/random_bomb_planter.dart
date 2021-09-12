import 'dart:math';
import 'package:minesweeper_in_flutter/models/bomb_plantable.dart';
import 'package:minesweeper_in_flutter/models/bomb_planter.dart';

class _Position {
  final int row;
  final int column;
  _Position(this.row, this.column);
}

class RandomBombPlanter implements BombPlanter {
  final Random _generator;
  RandomBombPlanter({int? seed}) : _generator = Random(seed);

  _Position _suggestNextPosition(BombPlantable field) {
    int row = _generator.nextInt(field.rows);
    int column = _generator.nextInt(field.columns);
    return _Position(row, column);
  }

  @override
  void plantBombs(BombPlantable field, int count) {
    for (int i = 0; i < count; ++i) {
      bool planted = false;
      do {
        var position = _suggestNextPosition(field);
        planted = field.tryPlantBomb(position.row, position.column);
      } while (!planted);
    }
  }
}
