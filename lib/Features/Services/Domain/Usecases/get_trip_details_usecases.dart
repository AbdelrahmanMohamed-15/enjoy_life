import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/service_deatils_entity.dart';
import '../Repository/service_repository.dart';

class GetTripDetailsUsecases {
  final ServiceRepository serviceRepository;
  GetTripDetailsUsecases({required this.serviceRepository});

  Future<Either<Failure, ServiceDetailsEntity>> call({
    required int tripID,
  }) async {
    return await serviceRepository.getTripByID(tripID: tripID);
  }
}
