import 'package:test/test.dart';
import 'package:minesweeper_in_flutter/utility.dart';

void main() {
  group('transformSurrounding', () {
    var parentGrid = [
      [1, 1, 1],
      [1, 1, 1],
      [1, 1, 1],
    ];
    var basicTest = (int row, int column, List<List<int>> result) {
      var grid = parentGrid.map((rowElements) => [...rowElements]).toList();
      transformSurrounding(
          grid, row, column, (int row, int column) => grid[row][column]++);
      expect(grid, equals(result));
    };
    test(
      'middle element',
      () => basicTest(1, 1, [
        [2, 2, 2],
        [2, 1, 2],
        [2, 2, 2],
      ]),
    );
    test(
      'top left',
      () => basicTest(0, 0, [
        [1, 2, 1],
        [2, 2, 1],
        [1, 1, 1],
      ]),
    );
    test(
      'top right',
      () => basicTest(0, 2, [
        [1, 2, 1],
        [1, 2, 2],
        [1, 1, 1],
      ]),
    );
    test(
      'bottom left',
      () => basicTest(2, 0, [
        [1, 1, 1],
        [2, 2, 1],
        [1, 2, 1],
      ]),
    );
    test(
      'bottom right',
      () => basicTest(2, 2, [
        [1, 1, 1],
        [1, 2, 2],
        [1, 2, 1],
      ]),
    );
  });
}
