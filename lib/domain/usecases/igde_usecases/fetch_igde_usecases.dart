import 'package:dartz/dartz.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/igde_datasources.dart';
import 'package:ignition/data/repositories/igde_repository_impl.dart';
import 'package:ignition/domain/entities/igde_entity.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';

class FetchIgdesUsecases {
  final FetchIgdesRepositoryImpl _fetchIgdesRepositoryImpl =
      FetchIgdesRepositoryImpl();
  Future<Either<IIgdeUsecaseExceptions, List<IgdeEntity>>> call(
      String token, IFetchIgdeDatasource datasource) async {
    return _fetchIgdesRepositoryImpl.call(token, datasource);
  }
}
