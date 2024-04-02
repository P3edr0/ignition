import 'package:dartz/dartz.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/igde_datasources.dart';
import 'package:ignition/data/repositories/igde_repository_impl.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';

class LoginIgdesUsecases {
  final LoginIgdesRepositoryImpl _loginIgdesRepositoryImpl =
      LoginIgdesRepositoryImpl();
  Future<Either<IIgdeUsecaseExceptions, Map>> call(
      Map userData, ILoginIgdeDatasource datasource) async {
    return _loginIgdesRepositoryImpl.call(userData, datasource);
  }
}
