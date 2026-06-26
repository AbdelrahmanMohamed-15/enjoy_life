import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';

import '../Repository/profile_repository.dart';

class DeleteAccountUsecases {
  final ProfileRepository profileRepository;
  DeleteAccountUsecases({required this.profileRepository});

  Future<Either<Failure, BaseEntity>> call() async {
    return await profileRepository.deleteAccount();
  }
}
