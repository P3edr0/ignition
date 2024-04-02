import 'package:dartz/dartz.dart';
import 'package:ignition/data/datasources/dio_datasources/user/delete_user_dio_datasource.dart';
import 'package:ignition/domain/usecases/user_usecases/user_exceptions.dart';

class DeleteUserUsecases {
  Future<Either<IUserUsecaseExceptions, String>> call(
    Map deleteData,
  ) async {
    if (deleteData['id'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (deleteData['id'] == null) {
      return Left(NullUserUsecaseExceptions());
    }
    if (deleteData['token'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (deleteData['token'] == null) {
      return Left(NullUserUsecaseExceptions());
    }

    return DeleteUserDioDatasourceImpl().call(deleteData);
  }
}
