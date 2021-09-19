import 'package:sqflite/sqflite.dart';

const String tableRecords = 'records';
const String columnId = '_id';
const String columnDuration = 'duration';
const String columnDateTime = 'datetime';

class Record {
  int? id;
  late DateTime dateTime;
  late Duration duration;
  Record(this.dateTime, this.duration);
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnDateTime: dateTime.toIso8601String(),
      columnDuration: duration.inSeconds,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Record.fromMap(Map<String, Object?> map) {
    var localDateTime = map[columnDateTime] as String?;
    dateTime = DateTime.parse(localDateTime!);
    var localDuration = map[columnDuration] as int?;
    duration = Duration(seconds: localDuration!);
    id = map[columnId] as int?;
  }
}

class RecordProvider {
  late Database _db;

  RecordProvider._create();

  static Future<RecordProvider> open(String path) async {
    var provider = RecordProvider._create();
    provider._db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
            create table $tableRecords ( 
              $columnId integer primary key autoincrement, 
              $columnDateTime text not null,
              $columnDuration integer not null)
            ''');
    });
    return provider;
  }

  Future<Record> insert(Record record) async {
    record.id = await _db.insert(tableRecords, record.toMap());
    return record;
  }

  Future<Record?> getRecord(int id) async {
    List<Map<String, Object?>> maps = await _db.query(
      tableRecords,
      columns: [columnId, columnDateTime, columnDuration],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.length == 0) return null;

    return Record.fromMap(maps.first);
  }

  Future<List<Record>> getRecords() async {
    List<Map<String, Object?>> maps = await _db.query(
      tableRecords,
      columns: [columnId, columnDateTime, columnDuration],
    );
    List<Record> records = [];
    for (var recordMap in maps) records.add(Record.fromMap(recordMap));
    return records;
  }

  Future<int?> delete(int id) async {
    return await _db.delete(
      tableRecords,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int?> update(Record record) async {
    return await _db.update(
      tableRecords,
      record.toMap(),
      where: '$columnId = ?',
      whereArgs: [record.id],
    );
  }

  Future close() async => _db.close();
}
