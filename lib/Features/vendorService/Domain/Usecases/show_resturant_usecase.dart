import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/resturant_deatils_entity.dart';

import '../../../../Core/Failures/failures.dart';
import '../Repository/vendor_service_repository.dart';

class ShowResturantUsecase {
  final VendorServiceRepository vendorServiceRepository;
  ShowResturantUsecase({required this.vendorServiceRepository});

  Future<Either<Failure, ResturantDeatilsEntity>> call({required int id}) =>
      vendorServiceRepository.showResturant(id: id);
}
