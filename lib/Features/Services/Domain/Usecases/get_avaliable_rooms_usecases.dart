import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Services/Domain/Entity/room_entity.dart';

import '../../../../Core/Failures/failures.dart';
import '../Repository/service_repository.dart';

class GetAvaliableRoomsUsecases {
  final ServiceRepository serviceRepository;
  GetAvaliableRoomsUsecases({required this.serviceRepository});

  Future<Either<Failure, RoomEntity>> call({
    required int hotelID,
    required String startDate,
    required String endDate,
  }) async => await serviceRepository.getAvaliableRooms(
    hotelID: hotelID,
    startDate: startDate,
    endDate: endDate,
  );
}
