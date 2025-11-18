import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/resturant_entity.dart';
import '../Repository/home_repository.dart';

class GetTripsUsecases {
  final HomeRepository homeRepository;
  GetTripsUsecases({required this.homeRepository});

  Future<Either<Failure, HomeEntity>> call() async {
    return await homeRepository.getTrips();
  }
}
