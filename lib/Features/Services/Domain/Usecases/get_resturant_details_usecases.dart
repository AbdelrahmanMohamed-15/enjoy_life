import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/Services/Domain/Entity/service_deatils_entity.dart';
import '../../../../Core/Failures/failures.dart';
import '../Repository/service_repository.dart';

class GetResturantDetailsUsecases {
  final ServiceRepository serviceRepository;
  GetResturantDetailsUsecases({required this.serviceRepository});

  Future<Either<Failure, ServiceDetailsEntity>> call({
    required int resturantId,
  }) async {
    return await serviceRepository.getResturantByID(resturantID: resturantId);
  }
}
