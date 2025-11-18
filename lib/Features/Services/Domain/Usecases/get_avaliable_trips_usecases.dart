import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Services/Domain/Entity/trip_entity.dart';

import '../../../../Core/Failures/failures.dart';
import '../Repository/service_repository.dart';

class GetAvaliableTripsUsecases {
  final ServiceRepository serviceRepository;
  GetAvaliableTripsUsecases({required this.serviceRepository});

  Future<Either<Failure, TripEntity>> getAvaliableTrips({
    required int tripID,
  }) async => await serviceRepository.getAvaliableTrips(tripID: tripID);
}
