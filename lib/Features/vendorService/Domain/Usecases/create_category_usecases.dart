import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_life/Features/vendorService/Domain/Repository/vendor_service_repository.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';

class CreateCategoryUsecases {
  final VendorServiceRepository vendorServiceRepository;
  CreateCategoryUsecases({required this.vendorServiceRepository});

  Future<Either<Failure, BaseEntity>> call({required FormData formData}) =>
      vendorServiceRepository.createCategory(formData: formData);
}
