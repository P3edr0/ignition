import 'package:dartz/dartz.dart';
import 'package:ignition/data/datasources/dio_datasources/user/insert_user_dio_datasource.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';

class InsertUserUsecases {
  Future<Either<IIgdeUsecaseExceptions, String>> call(
    Map userData,
  ) async {
    if (userData['name'] == '') {
      return Left(EmptyFieldCaseException('O campo nome não pode ser vazio'));
    }
    if (userData['name'] == null) {
      return Left(NullUsecaseExceptions('O campo nome não pode ser null'));
    }
    if (userData['email'] == '') {
      return Left(EmptyFieldCaseException('O campo email não pode ser vazio'));
    }
    if (userData['email'] == null) {
      return Left(NullUsecaseExceptions('O campo email não pode ser null'));
    }
    if (userData['tags'] == null) {
      return Left(NullUsecaseExceptions('As Tags não podem ser null'));
    }
    if (userData['token'] == '') {
      return Left(EmptyFieldCaseException('O Token não pode ser vazio'));
    }
    if (userData['token'] == null) {
      return Left(NullUsecaseExceptions('O Token não pode ser null'));
    }
    return InsertUserDioDatasourceImpl().call(userData);
  }
}
