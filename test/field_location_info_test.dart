import 'package:test/test.dart';
import 'package:minesweeper_in_flutter/models/field_location_info.dart';
import 'package:minesweeper_in_flutter/models/bomb_plant_advisor.dart';
import 'package:minesweeper_in_flutter/models/cells.dart';

class PredeterminedBombPlanAdvisor implements BombPlantAdvisor {
  List<Position> positions;
  int _index = 0;
  PredeterminedBombPlanAdvisor(this.positions) {
    assert(positions.isNotEmpty);
  }

  @override
  Position suggestNextPosition() => positions[(_index++) % positions.length];
}

void check(
    {required FieldLocationInfo field, required List<List<int>> values}) {
  expect(field.rows, equals(values.length));
  expect(field.columns, equals(values.first.length));
  for (int row = 0; row < field.rows; ++row)
    for (int column = 0; column < field.columns; ++column)
      expect(
        field.bombsAround(row, column),
        equals(
          values[row][column],
        ),
        reason: '$row, $column',
      );
}

void main() {
  group('FieldLocationInfo', () {
    test('size (3,3) bomb in the middle', () {
      check(
          field: FieldLocationInfo.generate(
            rows: 3,
            columns: 3,
            bombs: 1,
            advisor: PredeterminedBombPlanAdvisor([
              Position(1, 1),
            ]),
          ),
          values: [
            [Cells.val1, Cells.val1, Cells.val1],
            [Cells.val1, Cells.bomb, Cells.val1],
            [Cells.val1, Cells.val1, Cells.val1],
          ]);
    });
    test('size (3,3) no bomb in the middle', () {
      check(
          field: FieldLocationInfo.generate(
            rows: 3,
            columns: 3,
            bombs: 8,
            advisor: PredeterminedBombPlanAdvisor([
              Position(0, 0),
              Position(0, 1),
              Position(0, 2),
              Position(1, 0),
              Position(1, 2),
              Position(2, 0),
              Position(2, 1),
              Position(2, 2),
            ]),
          ),
          values: [
            [Cells.bomb, Cells.bomb, Cells.bomb],
            [Cells.bomb, Cells.val8, Cells.bomb],
            [Cells.bomb, Cells.bomb, Cells.bomb],
          ]);
    });
    test('size (5,5) diagonal bombs', () {
      check(
          field: FieldLocationInfo.generate(
            rows: 5,
            columns: 5,
            bombs: 5,
            advisor: PredeterminedBombPlanAdvisor([
              Position(0, 0),
              Position(1, 1),
              Position(2, 2),
              Position(3, 3),
              Position(4, 4),
            ]),
          ),
          values: [
            [Cells.bomb, Cells.val2, Cells.val1, Cells.empty, Cells.empty],
            [Cells.val2, Cells.bomb, Cells.val2, Cells.val1, Cells.empty],
            [Cells.val1, Cells.val2, Cells.bomb, Cells.val2, Cells.val1],
            [Cells.empty, Cells.val1, Cells.val2, Cells.bomb, Cells.val2],
            [Cells.empty, Cells.empty, Cells.val1, Cells.val2, Cells.bomb],
          ]);
    });
  });
}