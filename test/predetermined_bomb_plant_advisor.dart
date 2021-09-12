import 'package:minesweeper_in_flutter/models/bomb_plant_advisor.dart';

class PredeterminedBombPlantAdvisor implements BombPlantAdvisor {
  List<Position> positions;
  int _index = 0;
  PredeterminedBombPlantAdvisor(this.positions) {
    assert(positions.isNotEmpty);
  }

  @override
  Position suggestNextPosition() => positions[(_index++) % positions.length];
}
