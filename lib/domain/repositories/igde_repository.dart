import 'package:dartz/dartz.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/igde_datasources.dart';
import 'package:ignition/domain/entities/igde_entity.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';

abstract class IFetchIgdesRepository {
  Future<Either<IIgdeUsecaseExceptions, List<IgdeEntity>>> call(
      String token, IFetchIgdeDatasource datasource);
}

abstract class ILoginIgdesRepository {
  Future<Either<IIgdeUsecaseExceptions, Map>> call(
      Map userData, ILoginIgdeDatasource datasource);
}

abstract class IInsertIgdesRepository {
  Future<Either<IIgdeUsecaseExceptions, String>> call(
      Map userData, IInsertIgdeDatasource datasource);
}

abstract class IUpdateIgdesRepository {
  Future<Either<IIgdeUsecaseExceptions, String>> call(Map userData);
}

abstract class IDeleteIgdesRepository {
  Future<Either<IIgdeUsecaseExceptions, String>> call(
      Map userData, IDeleteIgdeDatasource datasource);
}
