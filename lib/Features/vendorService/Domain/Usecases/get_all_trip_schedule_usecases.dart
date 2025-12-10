import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_trip_schedual_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Repository/vendor_service_repository.dart';
import '../../../../Core/Failures/failures.dart';

class GetAllTripScheduleUsecases {
  final VendorServiceRepository vendorServiceRepository;
  GetAllTripScheduleUsecases({required this.vendorServiceRepository});

  Future<Either<Failure, AllTripScheduleEntity>> call() =>
      vendorServiceRepository.getAllTripSchedule();
}
