import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';
import '../Repository/reversion_repository.dart';

class ScanOrderUsecases {
  final ReversionRepository reversionRepository;
  ScanOrderUsecases({required this.reversionRepository});

  Future<Either<Failure, BaseEntity>> call({required String qrCode}) async {
    return await reversionRepository.scanOrder(qrCode: qrCode);
  }
}
