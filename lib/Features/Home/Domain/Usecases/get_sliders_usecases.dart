import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/slider_entity.dart';
import '../Repository/home_repository.dart';

class GetSlidersUsecases {
  final HomeRepository homeRepository;
  GetSlidersUsecases({required this.homeRepository});

  Future<Either<Failure, SliderEntity>> call() async {
    return await homeRepository.getSliders();
  }
}
