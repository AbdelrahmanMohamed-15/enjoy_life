import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/profile_entity.dart';
import '../Repository/profile_repository.dart';

class GetProfileUsecases {
  final ProfileRepository profileRepository;
  GetProfileUsecases({required this.profileRepository});
  Future<Either<Failure, ProfileEntity>> call() async {
    return await profileRepository.getProfile();
  }
}
