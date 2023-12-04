import 'package:get/get.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/providers/database/database_service.dart';
import 'package:sqflite/sqflite.dart';

class RunEntity {
  static const tableName = "run";
  static const ID = "id";
  static const TIMESTAMP = "timestamp";
  static const AVG_SPEED = "averageSpeedInKilometersPerHour";
  static const DISTANCE_IN_KILOMETERS = "distanceInKilometers";
  static const TIME_IN_MILLIS = "timeInMillis";
  static const CALORIES_BURNED = "caloriesBurned";
  static const IMAGE = "img";
  static const IS_RUN_WITH_EXERCISE = "isRunWithExercise";

  static const CREATE_TABLE = """CREATE TABLE IF NOT EXISTS $tableName (
    $ID VARCHAR(255) NOT NULL,
    $TIMESTAMP LONG,
    $AVG_SPEED DOUBLE,
    $DISTANCE_IN_KILOMETERS INT,
    $TIME_IN_MILLIS LONG,
    $CALORIES_BURNED INT,
    $IMAGE VARCHAR(255) NULL,
    $IS_RUN_WITH_EXERCISE INT,
    PRIMARY KEY($ID)
    )""";

  static Future<void> createTable(Database database) async {
    await database.execute(CREATE_TABLE);
  }

  static Future<int> create({required Run run}) async {
    final database = await Get.find<DatabaseService>().database;
    return await database.rawInsert(
        """INSERT INTO $tableName($ID, $TIMESTAMP, $AVG_SPEED, $DISTANCE_IN_KILOMETERS, 
          $TIME_IN_MILLIS, $CALORIES_BURNED, $IMAGE, $IS_RUN_WITH_EXERCISE) 
          VALUES(?, ?, ?, ?, ?, ?, ?, ?)""",
        [
          run.id,
          run.timestamp,
          run.averageSpeedInKilometersPerHour,
          run.distanceInKilometers,
          run.timeInMillis,
          run.caloriesBurned,
          run.img,
          run.isRunWithExercise
        ]);
  }

  static Future<List<Run>> getAll() async {
    final database = await Get.find<DatabaseService>().database;
    String sql = "SELECT * FROM $tableName ORDER BY $TIMESTAMP DESC";
    final runs = await database.rawQuery(sql);
    return runs.map((run) => Run.fromJson(run)).toList();
  }

  static Future<List<Run>> getAllByType({required int type}) async {
    final database = await Get.find<DatabaseService>().database;
    String sql =
        "SELECT * FROM $tableName WHERE $IS_RUN_WITH_EXERCISE = ? ORDER BY $TIMESTAMP DESC";
    final runs = await database.rawQuery(sql, [type]);
    return runs.map((run) => Run.fromJson(run)).toList();
  }

  static Future<Run> getById({required String id}) async {
    final database = await Get.find<DatabaseService>().database;
    String sql = "SELECT * FROM $tableName WHERE $ID = ?";
    final run = await database.rawQuery(sql, [id]);
    return Run.fromJson(run.first);
  }

  static Future<int> update({required Run run}) async {
    final database = await Get.find<DatabaseService>().database;
    return await database.update(
        tableName,
        {
          TIMESTAMP: run.timestamp,
          AVG_SPEED: run.averageSpeedInKilometersPerHour,
          DISTANCE_IN_KILOMETERS: run.distanceInKilometers,
          TIME_IN_MILLIS: run.timeInMillis,
          CALORIES_BURNED: run.caloriesBurned,
          IMAGE: run.img,
          IS_RUN_WITH_EXERCISE: run.isRunWithExercise
        },
        where: "$ID = ?",
        conflictAlgorithm: ConflictAlgorithm.rollback,
        whereArgs: [run.id]);
  }

  static Future<void> delete({required String id}) async {
    final database = await Get.find<DatabaseService>().database;
    String sql = "DELETE FROM $tableName WHERE $ID = ?";
    await database.rawDelete(sql, [id]);
  }
}
