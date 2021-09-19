import 'package:minesweeper_in_flutter/data/records_provider.dart';
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

  Future<void> insert({required Record record}) async {
    await _recordProvider.insert(record);
  }

  Future<List<Record>> getRecords() async {
    return await _recordProvider.getRecords();
  }

  late RecordProvider _recordProvider;
}
