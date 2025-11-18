import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';

import '../../../../Core/Failures/failures.dart';
import '../Repository/auth_repository.dart';

class RegisterUsecases {
  final AuthRepository authRepository;
  RegisterUsecases({required this.authRepository});

  Future<Either<Failure, BaseEntity>> call({
    required String dailCode,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String address,
  }) async {
    final result = await authRepository.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
      dailCode: dailCode,
      address: address,
      confirmPassword: confirmPassword,
    );
    return result;
  }
}
