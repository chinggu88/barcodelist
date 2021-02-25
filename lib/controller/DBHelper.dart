import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper extends GetxController {
  static final _databaseName = "Barcode";
  static final _databaseVersion = 1;

  static final table = 'barcodeinfo';

  static final columnSeq = 'seq'; //
  static final columnName = 'name'; //바코드 이름
  static final columnPath = 'imagepath'; //이미지위치
  static final columnAlias = 'alias'; //쓰는곳
  static final columnCnt = 'cnt'; //사용횟수

  //바코드 리스트
  List<Map<String, dynamic>> allrows = [];

  // only have a single app-wide reference to the database

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnSeq INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnPath TEXT NOT NULL,
            $columnAlias TEXT NOT NULL,
            $columnCnt INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods
  //바코드 데이터 저장
  Future<int> insertvarcode(Map<String, dynamic> row) async {
    Database db = await database;
    int result = await db.insert(table, row);
    update();
    return result;
  }

  //바코드 데이터 삭제
  Future<int> deletevarcode(int id) async {
    Database db = await database;
    return await db.delete(table, where: '$columnSeq = ?', whereArgs: [id]);
  }

  //바코드 클릭횟수 추가
  Future<int> updatecnt(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row[columnSeq];

    int result = await db.rawUpdate(
        'UPDATE barcodeinfo SET cnt = ? WHERE seq = ?',
        ['${row[columnCnt] + 1}', id]);

    return result;
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await database;
    int result = await db.insert(table, row);
    update();
    return result;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await database;
    allrows = await db.query(table, orderBy: "cnt DESC");
    update();
    return allrows;
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> updatewith(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row[columnSeq];
    return await db
        .update(table, row, where: '$columnSeq = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(table, where: '$columnSeq = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database db = await database;
    return await db.delete(table);
  }
}
