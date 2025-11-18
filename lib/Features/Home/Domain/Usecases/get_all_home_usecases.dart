import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/resturant_entity.dart';
import '../Repository/home_repository.dart';

class GetAllHomeUsecases {
  final HomeRepository homeRepository;
  GetAllHomeUsecases({required this.homeRepository});

  Future<Either<Failure, HomeEntity>> call({required String type}) async {
    return await homeRepository.getAllHome(type: type);
  }
}
