import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Authentication/Data/DataSource/auth_datasource.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Handler/response_code.dart';
import '../../../../Core/Handler/response_message.dart';
import '../../Domain/Entity/user_entity.dart';
import '../../Domain/Repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;
  AuthRepositoryImpl({required this.authDatasource});

  @override
  Future<Either<Failure, UserEntity>> login({
    required String dailCode,
    required String phone,
    required String password,
  }) async {
    try {
      var result = await authDatasource.login(
        dailCode: dailCode,
        phone: phone,
        password: password,
      );
      if (result.statusCode == 200) {
        return Right(UserEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } catch (e) {
      return Left(
        Failure(code: APIResponseCode.unknown, message: e.toString()),
      );
    }
  }
}
