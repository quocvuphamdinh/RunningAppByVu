class AppError {
  AppError(
      {this.errorCode = -1,
      this.errorMsg = "Error",
      this.errorTitle = "Unhandled Error"});
  int errorCode;
  String errorMsg;
  String errorTitle;
}
