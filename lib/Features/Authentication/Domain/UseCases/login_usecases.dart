import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/user_entity.dart';
import '../Repository/auth_repository.dart';

class LoginUsecases {
  final AuthRepository authRepository;
  LoginUsecases({required this.authRepository});

  Future<Either<Failure, UserEntity>> call({
    required String dailCode,
    required String phone,
    required String password,
  }) => authRepository.login(
    dailCode: dailCode,
    phone: phone,
    password: password,
  );
}
