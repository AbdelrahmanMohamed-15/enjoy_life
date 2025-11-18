import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';
import '../Repository/auth_repository.dart';

class RestPasswordUsecase {
  final AuthRepository authRepository;
  RestPasswordUsecase({required this.authRepository});

  Future<Either<Failure, BaseEntity>> call({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) => authRepository.resetPassword(
    email: email,
    newPassword: newPassword,
    confirmPassword: confirmPassword,
  );
}
