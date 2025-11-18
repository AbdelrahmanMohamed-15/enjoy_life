import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';
import '../Repository/auth_repository.dart';

class VerifyResetOtpUsecases {
  final AuthRepository authRepository;

  VerifyResetOtpUsecases({required this.authRepository});

  Future<Either<Failure, BaseEntity>> call({
    required String email,
    required String otp,
  }) => authRepository.verifyResntOTP(email: email, otp: otp);
}
