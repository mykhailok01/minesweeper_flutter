import 'package:test/test.dart';
import 'package:minesweeper_in_flutter/models/bombs_location_info.dart';
import 'package:minesweeper_in_flutter/models/cells.dart';
import 'predetermined_bomb_planter.dart';

void check(
    {required BombsLocationInfo field, required List<List<int>> values}) {
  expect(field.rows, equals(values.length));
  expect(field.columns, equals(values.first.length));
  for (int row = 0; row < field.rows; ++row)
    for (int column = 0; column < field.columns; ++column)
      expect(
        field.getCellInfo(row, column),
        equals(
          values[row][column],
        ),
        reason: '$row, $column',
      );
}

void main() {
  group('FieldLocationInfo', () {
    test('size (3,3) bomb in the middle', () {
      var locationInfo = BombsLocationInfo.generate(rows: 3, columns: 3);
      var planter = PredeterminedBombPlanter([Pos(1, 1)]);
      planter.plantBombs(locationInfo, 1);
      check(field: locationInfo, values: [
        [Cells.val1, Cells.val1, Cells.val1],
        [Cells.val1, Cells.bomb, Cells.val1],
        [Cells.val1, Cells.val1, Cells.val1],
      ]);
    });
    test('size (3,3) no bomb in the middle', () {
      var locationInfo = BombsLocationInfo.generate(rows: 3, columns: 3);
      var planter = PredeterminedBombPlanter([
        Pos(0, 0),
        Pos(0, 1),
        Pos(0, 2),
        Pos(1, 0),
        Pos(1, 2),
        Pos(2, 0),
        Pos(2, 1),
        Pos(2, 2),
      ]);
      planter.plantBombs(locationInfo, 8);
      check(field: locationInfo, values: [
        [Cells.bomb, Cells.bomb, Cells.bomb],
        [Cells.bomb, Cells.val8, Cells.bomb],
        [Cells.bomb, Cells.bomb, Cells.bomb],
      ]);
    });
    test('size (5,5) diagonal bombs', () {
      var locationInfo = BombsLocationInfo.generate(rows: 5, columns: 5);
      var planter = PredeterminedBombPlanter([
        Pos(0, 0),
        Pos(1, 1),
        Pos(2, 2),
        Pos(3, 3),
        Pos(4, 4),
      ]);
      planter.plantBombs(locationInfo, 5);
      check(field: locationInfo, values: [
        [Cells.bomb, Cells.val2, Cells.val1, Cells.empty, Cells.empty],
        [Cells.val2, Cells.bomb, Cells.val2, Cells.val1, Cells.empty],
        [Cells.val1, Cells.val2, Cells.bomb, Cells.val2, Cells.val1],
        [Cells.empty, Cells.val1, Cells.val2, Cells.bomb, Cells.val2],
        [Cells.empty, Cells.empty, Cells.val1, Cells.val2, Cells.bomb],
      ]);
    });
  });
}
