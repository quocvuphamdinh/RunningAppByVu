import 'package:path/path.dart';
import 'package:running_app_flutter/data/providers/database/entities/run_entity.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return database;
  }

  Future<void> create(Database database, int version) async =>
      await RunEntity.createTable(database);

  Future<String> get fullPath async {
    const name = 'vurunningapp.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }
}
