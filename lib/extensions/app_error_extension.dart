import 'package:running_app_flutter/constant/error_code.dart';
import 'package:running_app_flutter/data/models/app_error.dart';

extension AppErrorExtension on AppError {
  AppError badGateway() {
    errorTitle = "Error";
    errorCode = ErrorCode.BAD_GATEWAY;
    errorMsg = "Serever: Bad gateway";
    return this;
  }

  AppError badRequest() {
    errorTitle = "Error";
    errorCode = ErrorCode.BAD_REQUEST;
    errorMsg = "Serever: Bad request";
    return this;
  }

  AppError forbidden() {
    errorTitle = "Error";
    errorCode = ErrorCode.FORBIDDEN;
    errorMsg = "Serever: forbidden";
    return this;
  }

  AppError internalServerError() {
    errorTitle = "Error";
    errorCode = ErrorCode.INTERNAL_SERVER_ERROR;
    errorMsg = "Serever: Internal server error";
    return this;
  }

  AppError methodNotAllowed() {
    errorTitle = "Error";
    errorCode = ErrorCode.METHOD_NOT_ALLOWED;
    errorMsg = "Serever: method not allowed";
    return this;
  }

  AppError notAcceptable() {
    errorTitle = "Error";
    errorCode = ErrorCode.NOT_ACCEPTABLE;
    errorMsg = "Serever: Not acceptable";
    return this;
  }

  AppError notFound() {
    errorTitle = "Error";
    errorCode = ErrorCode.NOT_FOUND;
    errorMsg = "Serever: Not found";
    return this;
  }

  AppError notImplement() {
    errorTitle = "Error";
    errorCode = ErrorCode.NOT_IMPLEMENTED;
    errorMsg = "Serever: not implement";
    return this;
  }

  AppError requestTimeout() {
    errorTitle = "Error";
    errorCode = ErrorCode.REQUEST_TIMEOUT;
    errorMsg = "Serever: request timeout";
    return this;
  }

  AppError serviceUnavailable() {
    errorTitle = "Error";
    errorCode = ErrorCode.SERVICE_UNAVAILABLE;
    errorMsg = "Serever: service unavilable";
    return this;
  }

  AppError unAuthorized() {
    errorTitle = "Error";
    errorCode = ErrorCode.UNAUTHORIZED;
    errorMsg = "Serever: unauthorized";
    return this;
  }
}
