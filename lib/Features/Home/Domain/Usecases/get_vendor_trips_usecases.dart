import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/resturant_entity.dart';
import '../Repository/home_repository.dart';

class GetVendorTripsUsecases {
  final HomeRepository homeRepository;
  GetVendorTripsUsecases({required this.homeRepository});

  Future<Either<Failure, HomeEntity>> call() async {
    return await homeRepository.getVendorTrips();
  }
}
