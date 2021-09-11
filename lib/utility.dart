import 'dart:math';

void transformSurrounding<T>(
  List<List<T>> grid,
  int row,
  int column,
  void Function(int, int) func,
) {
  assert(grid.isNotEmpty);
  assert(grid.first.isNotEmpty);
  int rows = grid.length;
  int columns = grid.first.length;
  if (row - 1 >= 0) {
    int top = row - 1;
    for (int i = max(column - 1, 0); i < min(column + 2, columns); ++i)
      func(top, i);
  }
  if (column + 1 < columns) func(row, column + 1);
  if (row + 1 < rows) {
    int bottom = row + 1;
    for (int i = max(column - 1, 0); i < min(column + 2, columns); ++i)
      func(bottom, i);
  }
  if (column - 1 >= 0) func(row, column - 1);
}
