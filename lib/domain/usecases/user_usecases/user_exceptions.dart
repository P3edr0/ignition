abstract class IUserUsecaseExceptions implements Exception {
  final String message;
  IUserUsecaseExceptions([this.message = "Falha ao tentar buscar Clients"]);
}

class NullUserUsecaseExceptions extends IUserUsecaseExceptions {
  @override
  NullUserUsecaseExceptions(
      [String message = "O valor inserido não pode ser nulo"])
      : super(message);
}

class NotFoundUserCaseException extends IUserUsecaseExceptions {
  @override
  NotFoundUserCaseException([String message = "User não encontrado"])
      : super(message);
}

class InvalidDataUserCaseException extends IUserUsecaseExceptions {
  @override
  InvalidDataUserCaseException([String message = "Valor inserido não é válido"])
      : super(message);
}

class EmptyFieldCaseException extends IUserUsecaseExceptions {
  @override
  EmptyFieldCaseException([String message = "O campo não pode ser vazio"])
      : super(message);
}
