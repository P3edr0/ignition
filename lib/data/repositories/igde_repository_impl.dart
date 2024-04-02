import 'package:dartz/dartz.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/igde_datasources.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/update_igde_dio_datasource.dart';
import 'package:ignition/domain/entities/igde_entity.dart';
import 'package:ignition/domain/repositories/igde_repository.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';

class FetchIgdesRepositoryImpl implements IFetchIgdesRepository {
  @override
  Future<Either<IIgdeUsecaseExceptions, List<IgdeEntity>>> call(
      String token, IFetchIgdeDatasource datasource) async {
    // List<IgdeEntity> selectedIgde = [];
    try {
      var result = await datasource.call(token);
      return result.fold((l) => Left(l), (r) {
        return Right(r);
      });
    } catch (e) {
      return Left(NotFoundIgdeCaseException());
    }
  }
}

class LoginIgdesRepositoryImpl implements ILoginIgdesRepository {
  @override
  Future<Either<IIgdeUsecaseExceptions, Map>> call(
      Map userData, ILoginIgdeDatasource datasource) async {
    try {
      var result = await datasource.call(userData);
      return result.fold((l) => Left(l), (r) => Right(r));
    } catch (e) {
      return Left(NotFoundIgdeCaseException());
    }
  }
}

class InsertIgdesRepositoryImpl implements IInsertIgdesRepository {
  @override
  Future<Either<IIgdeUsecaseExceptions, String>> call(
      Map userData, IInsertIgdeDatasource datasource) async {
    try {
      var result = await datasource.call(userData);
      return result.fold((l) => Left(l), (r) => const Right('Sucesso'));
    } catch (e) {
      return Left(NotFoundIgdeCaseException());
    }
  }
}

class DeleteIgdesRepositoryImpl implements IDeleteIgdesRepository {
  @override
  Future<Either<IIgdeUsecaseExceptions, String>> call(
      Map deleteData, IDeleteIgdeDatasource datasource) async {
    try {
      var result = await datasource.call(deleteData);
      return result.fold((l) => Left(l), (r) {
        return Right(result.toString());
      });
    } catch (e) {
      return Left(NotFoundIgdeCaseException());
    }
  }
}

class UpdateIgdesRepositoryImpl implements IUpdateIgdesRepository {
  @override
  Future<Either<IIgdeUsecaseExceptions, String>> call(Map userData) async {
    try {
      var result = await UpdateIgdeDioDatasourceImpl().call(userData);
      return result.fold((l) => Left(l), (r) => const Right('Sucesso'));
    } catch (e) {
      return Left(NotFoundIgdeCaseException());
    }
  }
}
