
class CustomError implements Exception {
  final _message;
  CustomError([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "$_message";
  }
}
