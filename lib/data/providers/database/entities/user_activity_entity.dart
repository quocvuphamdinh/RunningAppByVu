import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:running_app_flutter/data/models/user_activity.dart';
import 'package:running_app_flutter/data/providers/database/database_service.dart';
import 'package:running_app_flutter/data/providers/database/entities/run_entity.dart';
import 'package:sqflite/sqflite.dart';

class UserActivityEntity {
  static const tableName = "user_exercise";
  static const ID = "id";
  static const RUN_ID = 'run';
  static const EXERCISE_ID = 'activityId';
  static const COMMENT = "comment";
  static const MOOD = "mood";

  static const CREATE_TABLE = """CREATE TABLE IF NOT EXISTS $tableName (
    $ID VARCHAR(255) NOT NULL,
    $RUN_ID VARCHAR(255),
    $EXERCISE_ID INT,
    $COMMENT VARCHAR(255),
    $MOOD INT,
    PRIMARY KEY($ID)
    )""";

  static Future<void> createTable(Database database) async {
    await database.execute(CREATE_TABLE);
  }

  static Future<int> create({required UserActivity userActivity}) async {
    final database = await Get.find<DatabaseService>().database;
    return await database.rawInsert(
        """INSERT INTO $tableName($ID, $RUN_ID, $EXERCISE_ID, $COMMENT, 
          $MOOD) 
          VALUES(?, ?, ?, ?, ?)""",
        [
          userActivity.id,
          userActivity.run!.id,
          userActivity.activityId,
          userActivity.comment,
          userActivity.mood,
        ]);
  }

  static Future<List<UserActivity>> getAll() async {
    final database = await Get.find<DatabaseService>().database;
    String sql = "SELECT * FROM $tableName";
    final userActivitys = await database.rawQuery(sql);
    final result = <UserActivity>[];
    for (var item in userActivitys) {
      var run = await RunEntity.getById(id: item[RUN_ID] as String);
      var userActivity = UserActivity.fromJson2(item, run);
      result.add(userActivity);
    }
    return result;
  }

  static Future<void> deleteAll() async {
    final database = await Get.find<DatabaseService>().database;
    String sql = "DELETE FROM $tableName";
    await database.rawDelete(sql);
  }
}
