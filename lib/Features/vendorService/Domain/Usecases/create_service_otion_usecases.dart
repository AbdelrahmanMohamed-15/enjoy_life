import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';
import '../Repository/vendor_service_repository.dart';

class CreateServiceOtionUsecases {
  final VendorServiceRepository vendorServiceRepository;
  CreateServiceOtionUsecases({required this.vendorServiceRepository});

  Future<Either<Failure, BaseEntity>> call({required FormData formData}) =>
      vendorServiceRepository.createServiceOtion(formData: formData);
}
