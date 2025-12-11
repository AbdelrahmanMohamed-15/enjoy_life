import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_category_entity.dart';
import '../Repository/vendor_service_repository.dart';

class GetAllCategoryUsecases {
  final VendorServiceRepository vendorServiceRepository;

  GetAllCategoryUsecases({required this.vendorServiceRepository});

  Future<Either<Failure, AllCategoryEntity>> getAllCategory() async {
    return await vendorServiceRepository.getAllCategory();
  }
}
