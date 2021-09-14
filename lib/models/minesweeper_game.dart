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
  CellsStatusManager field;
  late BombPlanter _planter;
  int _bombs;
  MinesweeperGame({
    required int rows,
    required int columns,
    required int bombs,
  })  : field = CellsStatusManager(
          locationInfo: BombsLocationInfo.generate(
            rows: rows,
            columns: columns,
          ),
        ),
        _bombs = bombs {
    _planter = RandomBombPlanter();
    _planter.plantBombs(field.locationInfo, bombs);
  }
  int get rows => field.rows;
  int get columns => field.columns;
  int get bombs => _bombs;

  GameStatus get status {
    if (field.disclosedBombCount > 0) return GameStatus.loosed;
    if (field.closedCount == field.locationInfo.bombs) return GameStatus.won;
    return GameStatus.ongoing;
  }

  int cellInfo(int row, int column) {
    if (field.cellStatus(row, column) == Cells.justOpenedBomb)
      return field.cellStatus(row, column);
    if (status != GameStatus.ongoing &&
        field.locationInfo.getCellInfo(row, column) == Cells.bomb)
      return field.locationInfo.getCellInfo(row, column);
    return field.cellStatus(row, column);
  }

  void discloseCell(int row, int column) {
    if (status == GameStatus.ongoing) {
      field.discloseCellInfo(row, column);
      notifyListeners();
    }
  }

  void restart() {
    field.resetStatuses();
    field.locationInfo.removeAllBombs();
    _planter.plantBombs(field.locationInfo, bombs);
    notifyListeners();
  }
}
