import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String dailCode,
    required String phone,
    required String password,
  });

  Future<Either<Failure, BaseEntity>> register({
    required String dailCode,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String address,
  });

  Future<Either<Failure, BaseEntity>> activeEmail({
    required String code,
    required String email,
  });

  Future<Either<Failure, BaseEntity>> forgetPassword({required String email});

  Future<Either<Failure, BaseEntity>> verifyResntOTP({
    required String email,
    required String otp,
  });

  Future<Either<Failure, BaseEntity>> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  });
}
