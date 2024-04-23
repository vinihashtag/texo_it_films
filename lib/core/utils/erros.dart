class CustomException implements Exception {
  final String message;
  final Exception? exception;
  final StackTrace? stackTrace;

  CustomException({required this.message, this.exception, this.stackTrace});
}

class ConnectionException implements Exception {
  final String message;

  ConnectionException({this.message = 'Sem conexão com a internet, verifique.'});
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException({this.message = 'Nenhum dado foi encontrado.'});
}

class CancelByUserException implements Exception {}

class UnexpectedException implements Exception {
  final Object exception;
  final StackTrace stackTrace;

  UnexpectedException({required this.exception, required this.stackTrace});
}
