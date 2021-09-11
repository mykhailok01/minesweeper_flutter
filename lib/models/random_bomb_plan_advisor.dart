import 'dart:math';
import 'package:minesweeper_in_flutter/models/bomb_plant_advisor.dart';

class RandomBombPlantAdvisor implements BombPlantAdvisor {
  final int rows;
  final int columns;
  final int? seed;
  final Random _generator;
  RandomBombPlantAdvisor({
    required this.rows,
    required this.columns,
    this.seed,
  }) : _generator = Random(seed);

  @override
  Position suggestNextPosition() {
    int row = _generator.nextInt(rows);
    int column = _generator.nextInt(columns);
    return Position(row, column);
  }
}
