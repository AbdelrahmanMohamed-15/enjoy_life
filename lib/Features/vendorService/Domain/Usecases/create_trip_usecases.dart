import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';
import '../Repository/vendor_service_repository.dart';

class CreateTripUsecases {
  final VendorServiceRepository vendorServiceRepository;
  CreateTripUsecases({required this.vendorServiceRepository});

  Future<Either<Failure, BaseEntity>> call({
    required FormData formData,
    required bool isEdit,
    int? id,
  }) => vendorServiceRepository.createTrip(
    formData: formData,
    isEdit: isEdit,
    id: id,
  );
}
