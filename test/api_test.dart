import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/delete_igde_dio_datasource.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/fetch_igde_dio_datasource.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/insert_igde_dio_datasource.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/login_igde_dio_datasource.dart';
import 'package:ignition/domain/entities/igde_entity.dart';
import 'package:ignition/domain/entities/user_entity.dart';
import 'package:ignition/domain/usecases/igde_usecases/delete_igde_usecases.dart';
import 'package:ignition/domain/usecases/igde_usecases/fetch_igde_usecases.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';
import 'package:ignition/domain/usecases/igde_usecases/insert_igde_usecases.dart';
import 'package:ignition/domain/usecases/igde_usecases/login_igde_usecases.dart';
import 'package:ignition/domain/usecases/igde_usecases/update_igde_usecases.dart';
import 'package:ignition/domain/usecases/user_usecases/delete_user_usecases.dart';
import 'package:ignition/domain/usecases/user_usecases/fetch_user_usecases.dart';
import 'package:ignition/domain/usecases/user_usecases/insert_user_usecases.dart';
import 'package:ignition/domain/usecases/user_usecases/update_user_usecases.dart';
import 'package:ignition/domain/usecases/user_usecases/user_exceptions.dart';

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Aqui estão os testes responsáveis por validar tanto as requisições, e seus 
escopos, como também a estrutura e o fluxo de cada requisição

Atenção: Ao fazer os testes certifique-se de estar utilizando um token válido, 
como também os números de id's e campos corretos 


*O token é necessário em todas as requests com excessão do login, onde ele é gerado.
*O endereço da Api está definido em uma 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

void main() {
  group('Api and request Structure tests', () {
    group('Igde request Structure Test', () {
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MDYxNzU0MzcsImV4cCI6MTcwNjE3OTAzN30.9bPQoJ34RGxNMHkE_Ec7BuQk1jCROw6DRyxVvIv93UU";
      test('Login test', () async {
/*Para fazer este teste utilize um igde que já esteja no inserido no banco, caso 
não tenha nenhum utilize a query  InsertIgdesUsecases.call() com os dados solicidados como no 
exemplo apresentado abaixo*/

        LoginIgdesUsecases loginUseCase = LoginIgdesUsecases();
        Map credentials = {
          "email": "eliasmamman@gmail.com",
          "password": "123456"
        };
        var result =
            await loginUseCase.call(credentials, LoginIgdeDioDatasourceImpl());

        expect(result, isA<Right<IIgdeUsecaseExceptions, Map>>());
        result.fold(
          (exception) {
            fail('Esperava uma Map, mas recebeu: $exception');
          },
          (value) {
            expect(value, isA<Map>());
          },
        );
      });

      test('Fetch igde api test', () async {
        FetchIgdesUsecases fetchIgdesUsecases = FetchIgdesUsecases();

        var result = await fetchIgdesUsecases.call(
          token,
          FetchIgdeDioDatasourceImpl(),
        );

        expect(result, isA<Right<IIgdeUsecaseExceptions, List<IgdeEntity>>>());
        result.fold(
          (exception) {
            fail('Esperava uma Map, mas recebeu: $exception');
          },
          (value) {
            expect(value, isA<List<IgdeEntity>>());
          },
        );
      });

      test('update igde api test', () async {
        UpdateIgdesUsecases updateIgdesUsecases = UpdateIgdesUsecases();

        var result = await updateIgdesUsecases.call(
          {
            'id': 15,
            "name": "kevin Marcius",
            "email": "kevin@gmail.com",
            "password": "12345678",
            "confirmPassword": "12345678",
            'token': token,
          },
        );

        expect(result, isA<Right<IIgdeUsecaseExceptions, String>>());
        result.fold(
          (exception) {
            fail('Esperava uma String, mas recebeu: $exception');
          },
          (value) {
            expect(value, isA<String>());
          },
        );
      });
      test('Insert igde api test', () async {
        InsertIgdesUsecases insertIgdesUsecases = InsertIgdesUsecases();

        var result = await insertIgdesUsecases.call({
          'name': 'Verena Weikert',
          'email': 'verena@gmail.com',
          'password': '12345',
          'confirmPassword': '12345'
        }, InsertIgdeDioDatasourceImpl());

        expect(result, isA<Right<IIgdeUsecaseExceptions, String>>());
        result.fold(
          (exception) {
            fail('Esperava uma String, mas recebeu: $exception');
          },
          (value) {
            expect(value, isA<String>());
          },
        );
      });

      test('Delete igde api test', () async {
        DeleteIgdesUsecases deleteIgdesUsecases = DeleteIgdesUsecases();

        var result = await deleteIgdesUsecases
            .call({"id": 14, "token": token}, DeleteIgdeDioDatasourceImpl());

        expect(result, isA<Right<IIgdeUsecaseExceptions, String>>());
        result.fold(
          (exception) {
            fail('Esperava uma String, mas recebeu: $exception');
          },
          (value) {
            expect(value, isA<String>());
          },
        );
      });
    });
  });

  group('User request Structure Test', () {
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MDYxNzMxMDYsImV4cCI6MTcwNjE3NjcwNn0.TI9tuP_AimeYJ7oq8Td7oY8fKZncZTwVHmKgMo_Bs-E';

    test('Fetch user api test', () async {
      FetchUserUsecases fetchUserUsecases = FetchUserUsecases();

      var result = await fetchUserUsecases.call(
        token,
      );

      expect(result, isA<Right<IUserUsecaseExceptions, List<UserEntity>>>());
      result.fold(
        (exception) {
          fail('Esperava uma lista, mas recebeu: $exception');
        },
        (value) {
          expect(value, isA<List<UserEntity>>());
        },
      );
    });

    test('update user api test', () async {
      UpdateUserUsecases updateUserUsecases = UpdateUserUsecases();

      var result = await updateUserUsecases.call(
        {
          'id': 1,
          "name": "kevin Duran",
          "email": "kevin@gmail.com",
          "tags": "imoveis",
          'token': token,
        },
      );

      expect(result, isA<Right<IIgdeUsecaseExceptions, String>>());
      result.fold(
        (exception) {
          fail('Esperava uma String, mas recebeu: $exception');
        },
        (value) {
          expect(value, isA<String>());
        },
      );
    });

    test('Delete user api test', () async {
      DeleteUserUsecases deleteUserUsecases = DeleteUserUsecases();

      var result = await deleteUserUsecases.call({"id": 1, "token": token});

      expect(result, isA<Right<IUserUsecaseExceptions, String>>());
      result.fold(
        (exception) {
          fail('Esperava uma String, mas recebeu: $exception');
        },
        (value) {
          expect(value, isA<String>());
        },
      );
    });
    test('Create user api test', () async {
      InsertUserUsecases insertUserUsecases = InsertUserUsecases();

      var result = await insertUserUsecases.call(
        {
          'name': 'Verena Weikert',
          'email': 'verena@gmail.com',
          'tags': 'Arte,Musica',
          'confirmPassword': '12345',
          'token': token,
        },
      );

      expect(result, isA<Right<IIgdeUsecaseExceptions, String>>());
      result.fold(
        (exception) {
          fail('Esperava uma String, mas recebeu: $exception');
        },
        (value) {
          expect(value, isA<String>());
        },
      );
    });
  });
}
