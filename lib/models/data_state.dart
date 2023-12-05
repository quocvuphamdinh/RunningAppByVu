import 'package:running_app_flutter/models/app_error.dart';

abstract class DataState<T> {
  final T? data;
  final AppError? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(AppError error) : super(error: error);
}
