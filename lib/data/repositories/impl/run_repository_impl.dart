import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/providers/database/entities/run_entity.dart';
import 'package:running_app_flutter/data/repositories/run_repository.dart';

class RunRepositoryImpl extends RunRepository {
  @override
  Future<int> insertRun({required Run run}) {
    return RunEntity.create(run: run);
  }

  @override
  Future<List<Run>> getAllByType({required int type}) {
    return RunEntity.getAllByType(type: type);
  }

  @override
  Future<Run> getRunById({required String id}) {
    return RunEntity.getById(id: id);
  }
}
