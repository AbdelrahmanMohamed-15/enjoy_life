import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Services/Domain/Repository/service_repository.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/service_deatils_entity.dart';

class GetHotelDetailsUsecases {
  final ServiceRepository servicesRepository;
  GetHotelDetailsUsecases({required this.servicesRepository});

  Future<Either<Failure, ServiceDetailsEntity>> call({
    required int hotelID,
  }) async {
    return await servicesRepository.getHotelByID(hotelID: hotelID);
  }
}
