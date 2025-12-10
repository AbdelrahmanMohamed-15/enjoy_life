import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/hotel_details_entity.dart';

import '../../../../Core/Failures/failures.dart';
import '../Repository/vendor_service_repository.dart';

class ShowHotelUsecases {
  final VendorServiceRepository vendorServiceRepository;
  ShowHotelUsecases({required this.vendorServiceRepository});

  Future<Either<Failure, HotelDetailsEntity>> call({required int id}) =>
      vendorServiceRepository.showHotel(id: id);
}
