import 'package:dartz/dartz.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/igde_datasources.dart';
import 'package:ignition/data/repositories/igde_repository_impl.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';

class DeleteIgdesUsecases {
  final DeleteIgdesRepositoryImpl _deleteIgdesRepositoryImpl =
      DeleteIgdesRepositoryImpl();
  Future<Either<IIgdeUsecaseExceptions, String>> call(
      Map deleteData, IDeleteIgdeDatasource datasource) async {
    if (deleteData['id'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (deleteData['id'] == null) {
      return Left(NullUsecaseExceptions());
    }
    if (deleteData['token'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (deleteData['token'] == null) {
      return Left(NullUsecaseExceptions());
    }

    return _deleteIgdesRepositoryImpl.call(deleteData, datasource);
  }
}
