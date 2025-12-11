import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Features/Reversion/Domain/Entities/reversion_entity.dart';

abstract class ReversionRepository {
  Future<Either<Failure, ReversionEntity>> getReversion({
    required String status,
    required int serviceID,
  });

  Future<Either<Failure, BaseEntity>> scanOrder({required String qrCode});
}
