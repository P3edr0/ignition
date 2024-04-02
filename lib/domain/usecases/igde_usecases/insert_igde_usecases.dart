import 'package:dartz/dartz.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/igde_datasources.dart';
import 'package:ignition/data/repositories/igde_repository_impl.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';

class InsertIgdesUsecases {
  final InsertIgdesRepositoryImpl _insertIgdesRepositoryImpl =
      InsertIgdesRepositoryImpl();
  Future<Either<IIgdeUsecaseExceptions, String>> call(
      Map userData, IInsertIgdeDatasource datasource) async {
    if (userData['name'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (userData['name'] == null) {
      return Left(NullUsecaseExceptions());
    }
    if (userData['email'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (userData['email'] == null) {
      return Left(NullUsecaseExceptions());
    }
    if (userData['email'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (userData['email'] == null) {
      return Left(NullUsecaseExceptions());
    }
    if (userData['password'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (userData['password'] == null) {
      return Left(NullUsecaseExceptions());
    }
    if (userData['confirmPassword'] != userData['password']) {
      return Left(InvalidDataIgdeCaseException());
    }
    if (userData['confirmPassword'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (userData['confirmPassword'] == null) {
      return Left(NullUsecaseExceptions());
    }

    return _insertIgdesRepositoryImpl.call(userData, datasource);
  }
}
