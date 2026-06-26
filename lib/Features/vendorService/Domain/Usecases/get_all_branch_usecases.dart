import 'package:dartz/dartz.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_branch_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Repository/vendor_service_repository.dart';
import '../../../../Core/Failures/failures.dart';

class GetAllBranchUsecases {
  final VendorServiceRepository vendorServiceRepository;
  GetAllBranchUsecases({required this.vendorServiceRepository});

  Future<Either<Failure, AllBranchEntity>> call() =>
      vendorServiceRepository.getAllBranches();
}
