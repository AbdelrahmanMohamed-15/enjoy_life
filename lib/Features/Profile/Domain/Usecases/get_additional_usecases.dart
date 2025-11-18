import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Profile/Domain/Entity/additional_entity.dart';

import '../../../../Core/Failures/failures.dart';
import '../Repository/profile_repository.dart';

class GetAdditionalUsecases {
  final ProfileRepository profileRepository;
  GetAdditionalUsecases({required this.profileRepository});

  Future<Either<Failure, AdditionalEntity>> call({required String type}) async {
    return await profileRepository.getAdditionalPage(type: type);
  }
}
