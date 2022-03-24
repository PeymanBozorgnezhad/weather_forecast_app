/*
import 'package:http/http.dart';

class CustomException implements Exception {
  String cause;
  int response;

  CustomException({required this.response, required this.cause});

  void main() {
    try {
      throwException();
    } on CustomException {
      print('custom exception has been obtained');
    }
  }

  throwException() {
    throw CustomException(response: response, cause: cause);
  }
}
*/
class HTTPException implements Exception {
  final int code;
  final String message;

  HTTPException({required this.code, required this.message}) : assert(code != null);

  @override
  String toString() {
    return 'HTTPException{code: $code, message: $message}';
  }
}