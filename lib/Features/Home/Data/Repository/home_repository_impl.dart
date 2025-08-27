import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Home/Data/DataSource/home_datasource.dart';

import '../../../../Core/Failures/failures.dart';
import '../../../../Core/Handler/response_code.dart';
import '../../../../Core/Handler/response_message.dart';
import '../../Domain/Entity/slider_entity.dart';
import '../../Domain/Repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource homeDatasource;

  HomeRepositoryImpl({required this.homeDatasource});
  @override
  Future<Either<Failure, SliderEntity>> getSliders() async {
    try {
      var result = await homeDatasource.getSliders();
      if (result.statusCode == 200) {
        return Right(SliderEntity.fromJson(result.data));
      } else {
        return Left(
          Failure(
            code: result.statusCode ?? APIResponseCode.unknown,
            message: APIResponseMessages.unknown,
          ),
        );
      }
    } catch (e) {
      return Left(
        Failure(code: APIResponseCode.unknown, message: e.toString()),
      );
    }
  }
}
