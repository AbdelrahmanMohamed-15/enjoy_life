import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Home/Domain/Repository/home_repository.dart';

import '../../../../Core/Failures/failures.dart';
import '../Entity/search_entity.dart';

class SearchUsecases {
  final HomeRepository homeRepository;
  SearchUsecases({required this.homeRepository});
  Future<Either<Failure, SearchEntity>> call({required String query}) async {
    return await homeRepository.search(query: query);
  }
}
