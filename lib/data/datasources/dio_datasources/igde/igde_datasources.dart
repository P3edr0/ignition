import "package:dartz/dartz.dart";
import 'package:ignition/domain/entities/igde_entity.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';

abstract class IFetchIgdeDatasource {
  Future<Either<IIgdeUsecaseExceptions, List<IgdeEntity>>> call(String token);
}

abstract class ILoginIgdeDatasource {
  Future<Either<IIgdeUsecaseExceptions, Map>> call(Map data);
}

abstract class IInsertIgdeDatasource {
  Future<Either<IIgdeUsecaseExceptions, String>> call(Map userData);
}

abstract class IDeleteIgdeDatasource {
  Future<Either<IIgdeUsecaseExceptions, String>> call(Map deleteData);
}

abstract class IUpdateIgdeDatasource {
  Future<Either<IIgdeUsecaseExceptions, String>> call(Map updateData);
}
