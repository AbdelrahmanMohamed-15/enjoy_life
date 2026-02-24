import 'package:dartz/dartz.dart';
import 'package:easy_life/Core/Failures/failures.dart';
import 'package:easy_life/Features/Services/Domain/Repository/service_repository.dart';

import '../../../../Core/Helper/base_entity.dart';

class AddToCartUsecases {
  final ServiceRepository serviceRepository;

  AddToCartUsecases({required this.serviceRepository});

  Future<Either<Failure, BaseEntity>> call({
    required String type,
    int? id,
    int? branchID,
    int? tableID,
    int? roomID,
    int? tripID,
    String? startDate,
    String? endDate,
    int? optionID,
  }) async => await serviceRepository.addToCart(
    type: type,
    id: id,
    branchID: branchID,
    tableID: tableID,
    roomID: roomID,
    tripID: tripID,
    startDate: startDate,
    endDate: endDate,
    optionID: optionID,
  );
}
