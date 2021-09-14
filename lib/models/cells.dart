class Cells {
  Cells._();
  static const cellsStatusBegin = -3;
  static const justOpenedBomb = -3;
  static const closed = -2;
  static const cellsInfoBegin = -1;
  static const bomb = -1;
  static const empty = 0;
  static const val1 = 1;
  static const val2 = 2;
  static const val3 = 3;
  static const val4 = 4;
  static const val5 = 5;
  static const val6 = 6;
  static const val7 = 7;
  static const val8 = 8;
  static const cellsInfoEnd = 8;
  static const cellsStatusEnd = 8;
}

class CellsInfo {
  int get val => _val;
  CellsInfo(int val) : _val = val {
    if (val < Cells.cellsInfoBegin || Cells.cellsInfoEnd < val)
      throw FormatException('CellsInfo val $val out of bound');
  }
  void increment() {
    if (val < Cells.empty || Cells.val7 < val)
      throw FormatException('Increment CellsInfo val $val out of bound');
    ++_val;
  }

  int _val;
}

class CellsStatus {
  int get val => _val;
  CellsStatus(int val) : _val = val {
    if (val < Cells.cellsStatusBegin || Cells.cellsStatusEnd < val)
      throw FormatException('CellsStatus val $val out of bound');
  }
  int _val;
}
