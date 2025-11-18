import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/Features/Profile/Domain/Entity/profile_entity.dart';

import '../../../../Core/Failures/failures.dart';
import '../Repository/profile_repository.dart';

class UpdateProfileUsecases {
  final ProfileRepository profileRepository;

  UpdateProfileUsecases({required this.profileRepository});

  Future<Either<Failure, ProfileEntity>> call({
    required FormData formData,
  }) async {
    return await profileRepository.updateProfile(formData: formData);
  }
}
