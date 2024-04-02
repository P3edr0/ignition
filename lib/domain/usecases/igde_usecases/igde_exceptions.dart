abstract class IIgdeUsecaseExceptions implements Exception {
  final String message;
  IIgdeUsecaseExceptions([this.message = "Falha ao tentar buscar Igdes"]);
}

class NullUsecaseExceptions extends IIgdeUsecaseExceptions {
  @override
  NullUsecaseExceptions([String message = "O valor inserido não pode ser nulo"])
      : super(message);
}

class NotFoundIgdeCaseException extends IIgdeUsecaseExceptions {
  @override
  NotFoundIgdeCaseException([String message = "Igde não encontrado"])
      : super(message);
}

class InvalidDataIgdeCaseException extends IIgdeUsecaseExceptions {
  @override
  InvalidDataIgdeCaseException([String message = "Valor inserido não é válido"])
      : super(message);
}

class EmptyFieldCaseException extends IIgdeUsecaseExceptions {
  @override
  EmptyFieldCaseException([String message = "O campo não pode ser vazio"])
      : super(message);
}
