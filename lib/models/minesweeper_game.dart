import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:minesweeper_in_flutter/models/cells.dart';
import 'package:minesweeper_in_flutter/models/cells_status_manager.dart';
import 'package:minesweeper_in_flutter/models/bombs_location_info.dart';
import 'package:minesweeper_in_flutter/models/bomb_planter.dart';
import 'package:minesweeper_in_flutter/models/random_bomb_planter.dart';

enum GameStatus {
  loosed,
  won,
  ongoing,
}

class MinesweeperGame with ChangeNotifier {
  MinesweeperGame({
    required int rows,
    required int columns,
    required int bombs,
  })  : _field = CellsStatusManager(
          locationInfo: BombsLocationInfo.generate(
            rows: rows,
            columns: columns,
          ),
        ),
        _bombs = bombs {
    _planter = RandomBombPlanter();
    _planter.plantBombs(_field.locationInfo, bombs);
    _timer = Timer.periodic(Duration(seconds: 1), _handleTimeout);
  }
  int get rows => _field.rows;
  int get columns => _field.columns;
  int get bombs => _bombs;

  GameStatus get status {
    if (_field.disclosedBombCount > 0) return GameStatus.loosed;
    if (_field.closedCount == _field.locationInfo.bombs) return GameStatus.won;
    return GameStatus.ongoing;
  }

  int get time => _time;

  int cellInfo(int row, int column) {
    if (_field.cellStatus(row, column) == Cells.justOpenedBomb)
      return _field.cellStatus(row, column);
    if (status != GameStatus.ongoing &&
        _field.locationInfo.getCellInfo(row, column) == Cells.bomb)
      return _field.locationInfo.getCellInfo(row, column);
    return _field.cellStatus(row, column);
  }

  void discloseCell(int row, int column) {
    if (status == GameStatus.ongoing) {
      _field.discloseCellInfo(row, column);
      notifyListeners();
    }
  }

  void restart() {
    _field.resetStatuses();
    _field.locationInfo.removeAllBombs();
    _planter.plantBombs(_field.locationInfo, bombs);
    _time = 0;
    notifyListeners();
  }

  void _handleTimeout(Timer timer) {
    if (_timer != timer) return;
    if (status == GameStatus.ongoing) ++_time;
    notifyListeners();
  }

  CellsStatusManager _field;
  late BombPlanter _planter;
  int _bombs;
  int _time = 0;
  late Timer _timer;
}
