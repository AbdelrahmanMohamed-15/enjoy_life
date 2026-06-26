import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';
import '../Repository/vendor_service_repository.dart';

class CreateServiceUsecases {
  final VendorServiceRepository vendorServiceRepository;
  CreateServiceUsecases({required this.vendorServiceRepository});

  Future<Either<Failure, BaseEntity>> call({required FormData formData}) =>
      vendorServiceRepository.createService(formData: formData);
}
