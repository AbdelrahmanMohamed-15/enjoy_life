import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Features/Profile/Domain/Entity/profile_entity.dart';

import '../Entity/additional_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required FormData formData,
  });
  Future<Either<Failure, AdditionalEntity>> getAdditionalPage({
    required String type,
  });
}
