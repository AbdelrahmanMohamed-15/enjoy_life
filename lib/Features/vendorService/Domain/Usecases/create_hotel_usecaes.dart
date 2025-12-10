import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Helper/base_entity.dart';
import '../Repository/vendor_service_repository.dart';

class CreateHotelUsecaes {
  final VendorServiceRepository vendorServiceRepository;
  CreateHotelUsecaes({required this.vendorServiceRepository});

  Future<Either<Failure, BaseEntity>> call({
    required FormData formData,
    required bool isEdit,
    int? id,
  }) => vendorServiceRepository.createHotel(
    formData: formData,
    isEdit: isEdit,
    id: id,
  );
}
