import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Failures/failures.dart';

import '../Entity/slider_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, SliderEntity>> getSliders();
}
