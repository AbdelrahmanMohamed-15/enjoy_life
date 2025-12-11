import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entities/all_service_entity.dart';
import '../Repository/vendor_service_repository.dart';

class GetAllServiceUsecases {
  final VendorServiceRepository vendorServiceRepository;
  GetAllServiceUsecases({required this.vendorServiceRepository});

  Future<Either<Failure, AllServiceEntity>> call() =>
      vendorServiceRepository.getAllService();
}
