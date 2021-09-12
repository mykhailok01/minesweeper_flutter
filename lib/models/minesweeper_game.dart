import 'package:flutter/foundation.dart';
import 'package:minesweeper_in_flutter/models/cells_status_manager.dart';
import 'package:minesweeper_in_flutter/models/mines_location_info.dart';
import 'package:minesweeper_in_flutter/models/random_bomb_plant_advisor.dart';

enum GameStatus {
  loosed,
  won,
  ongoing,
}

class MinesweeperGame with ChangeNotifier {
  CellsStatusManager field;
  MinesweeperGame({
    required int rows,
    required int columns,
    required int bombs,
  }) : field = CellsStatusManager(
          info: MinesLocationInfo.generate(
            rows: rows,
            columns: columns,
            bombs: bombs,
            advisor: RandomBombPlantAdvisor(columns: columns, rows: rows),
          ),
        );
  int get rows => field.rows;
  int get columns => field.columns;
  int get bombs => field.info.bombs;

  GameStatus get status {
    if (field.disclosedBombCount > 0) return GameStatus.loosed;
    if (field.closedCount == field.info.bombs) return GameStatus.won;
    return GameStatus.ongoing;
  }

  int cellInfo(int row, int column) {
    return field.cellStatus(row, column);
  }

  void discloseCell(int row, int column) {
    if (status == GameStatus.ongoing) {
      field.discloseCellInfo(row, column);
      notifyListeners();
    }
  }

  void restart() {
    field = CellsStatusManager(
      info: MinesLocationInfo.generate(
        rows: rows,
        columns: columns,
        bombs: field.info.bombs,
        advisor: RandomBombPlantAdvisor(columns: columns, rows: rows),
      ),
    );
    notifyListeners();
  }
}
