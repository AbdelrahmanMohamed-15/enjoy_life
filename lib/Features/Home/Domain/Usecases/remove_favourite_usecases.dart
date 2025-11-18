import 'package:dartz/dartz.dart';

import '../../../../Core/Failures/failures.dart';
import '../Repository/home_repository.dart';

class RemoveFavouriteUsecases {
  final HomeRepository homeRepository;
  RemoveFavouriteUsecases({required this.homeRepository});
  Future<Either<Failure, bool>> call({
    required int id,
    required String type,
  }) async {
    return await homeRepository.removeFavourite(id: id, type: type);
  }
}
