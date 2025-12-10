import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/trip_details_entity.dart';

import '../../../../Core/Failures/failures.dart';
import '../Repository/vendor_service_repository.dart';

class ShowTripUsecases {
  final VendorServiceRepository vendorServiceRepository;
  ShowTripUsecases({required this.vendorServiceRepository});

  Future<Either<Failure, TripDetailsEntity>> call({required int id}) =>
      vendorServiceRepository.showTrip(id: id);
}
