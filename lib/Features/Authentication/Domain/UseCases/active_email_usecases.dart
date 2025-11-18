import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';
import '../Repository/auth_repository.dart';

class ActiveEmailUsecases {
  final AuthRepository authRepository;
  ActiveEmailUsecases({required this.authRepository});

  Future<Either<Failure, BaseEntity>> call({
    required String code,
    required String email,
  }) => authRepository.activeEmail(code: code, email: email);
}
