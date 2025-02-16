extension ExceptionMessageExtentsion on Exception? {
  String getMessage() {
    return toString().replaceAll("Exception:", "");
  }
}
