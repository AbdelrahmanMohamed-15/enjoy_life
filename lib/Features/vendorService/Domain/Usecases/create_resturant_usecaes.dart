import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';
import '../Repository/vendor_service_repository.dart';

class CreateResturantUsecaes {
  final VendorServiceRepository vendorServiceRepository;
  CreateResturantUsecaes({required this.vendorServiceRepository});

  Future<Either<Failure, BaseEntity>> call({
    required FormData formData,
    required bool isEdit,
    int? id,
  }) => vendorServiceRepository.createResturant(
    formData: formData,
    isEdit: isEdit,
    id: id,
  );
}
