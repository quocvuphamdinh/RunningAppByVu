import 'package:running_app_flutter/data/models/run.dart';

abstract class RunRepository {
  Future<int> insertRun({required Run run});
  Future<List<Run>> getAllByType({required int type});
  Future<Run> getRunById({required String id});
}
