class Position {
  final int row;
  final int column;
  Position(this.row, this.column);
}

abstract class BombPlantAdvisor {
  Position suggestNextPosition();
}
