import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';
import '../Repository/auth_repository.dart';

class ForgetPasswordUsecases {
  final AuthRepository authRepository;
  ForgetPasswordUsecases({required this.authRepository});

  Future<Either<Failure, BaseEntity>> call({required String email}) =>
      authRepository.forgetPassword(email: email);
}
