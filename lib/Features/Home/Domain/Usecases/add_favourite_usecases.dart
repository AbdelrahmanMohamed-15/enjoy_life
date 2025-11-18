import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Home/Domain/Repository/home_repository.dart';

import '../../../../Core/Failures/failures.dart';

class AddFavouriteUsecases {
  final HomeRepository homeRepository;
  AddFavouriteUsecases({required this.homeRepository});

  Future<Either<Failure, bool>> call({
    required int id,
    required String type,
  }) async {
    return await homeRepository.addFavourite(id: id, type: type);
  }
}
