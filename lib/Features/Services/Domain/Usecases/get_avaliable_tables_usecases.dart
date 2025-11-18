import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Features/Services/Domain/Entity/table_entity.dart';

import '../Repository/service_repository.dart';

class GetAvaliableTablesUsecases {
  final ServiceRepository serviceRepository;
  GetAvaliableTablesUsecases({required this.serviceRepository});

  Future<Either<Failure, TableEntity>> call({
    required int resturantID,
    required String startDate,
    required String endDate,
  }) async => await serviceRepository.getAvaliableTables(
    resturantID: resturantID,
    startDate: startDate,
    endDate: endDate,
  );
}
