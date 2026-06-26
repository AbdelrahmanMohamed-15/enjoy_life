import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Reversion/Domain/Repository/reversion_repository.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entities/reversion_entity.dart';

class GetAllReversionUsecases {
  final ReversionRepository reversionRepository;
  GetAllReversionUsecases({required this.reversionRepository});

  Future<Either<Failure, ReversionEntity>> call({
    required String status,
    required int serviceID,
  }) async {
    return await reversionRepository.getReversion(
      status: status,
      serviceID: serviceID,
    );
  }
}
