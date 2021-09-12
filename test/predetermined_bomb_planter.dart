import 'package:minesweeper_in_flutter/models/bomb_plantable.dart';
import 'package:minesweeper_in_flutter/models/bomb_planter.dart';

class Pos {
  int row;
  int column;
  Pos(this.row, this.column);
}

class PredeterminedBombPlanter implements BombPlanter {
  List<Pos> positions;
  PredeterminedBombPlanter(this.positions) {
    assert(positions.isNotEmpty);
  }

  @override
  void plantBombs(BombPlantable field, int count) {
    for (Pos p in positions) field.tryPlantBomb(p.row, p.column);
  }
}
