import 'package:minesweeper_in_flutter/data/records_provider.dart';
import 'package:minesweeper_in_flutter/models/minesweeper_game.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class RecordManager {
  RecordManager._create();

  static Future<RecordManager> create() async {
    RecordManager recordManager = RecordManager._create();
    String databasesPath = await getDatabasesPath();
    var path = p.join(databasesPath, 'records.db');
    recordManager._recordProvider = await RecordProvider.open(path);
    return recordManager;
  }

  Future<void> insert({
    required GameStatus status,
    required Duration duration,
  }) async {
    if (_prevStatus != GameStatus.won && status == GameStatus.won) {
      await _recordProvider.insert(Record(DateTime.now(), duration));
    }
    _prevStatus = status;
  }

  Future<List<Record>> getRecords() async {
    return await _recordProvider.getRecords();
  }

  late RecordProvider _recordProvider;
  GameStatus _prevStatus = GameStatus.notStarted;
}
