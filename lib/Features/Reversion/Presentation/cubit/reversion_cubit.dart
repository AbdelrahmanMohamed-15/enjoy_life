import 'package:easy_life/Core/Helper/safe_emit_mixin.dart';
import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:easy_life/Features/Reversion/Domain/Entities/reversion_entity.dart';
import 'package:easy_life/Features/Reversion/Domain/Usecases/get_all_reversion_usecases.dart';
import 'package:easy_life/Features/Reversion/Domain/Usecases/scan_order_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../Core/Themes/app_colors.dart';
part 'reversion_state.dart';

class ReversionCubit extends Cubit<ReversionState>
    with SafeEmitMixin<ReversionState> {
  ReversionCubit({
    required this.getAllReversionUsecases,
    required this.scanOrderUsecases,
  }) : super(ReversionInitial());
  static ReversionCubit get(context) => BlocProvider.of(context);

  // reversion UseCases
  final GetAllReversionUsecases getAllReversionUsecases;
  final ScanOrderUsecases scanOrderUsecases;

  // reversion State
  RequestState reversionRequestState = RequestState.loading;

  // reversion Variables
  ReversionEntity? reversionEntity;
  String status = 'pending';
  int serviceID = 1; // 1 for resturant 2 for hotel 3 for trip

  // reversion Functions
  void setReversionStatus({String? reversionStatus, int? servID}) {
    if (reversionStatus != null) status = reversionStatus;
    if (servID != null) serviceID = servID;
    emit(SetReversionStatus(status: reversionStatus, serviceID: servID));
    getAllReversion();
  }

  getAllReversion() async {
    reversionRequestState = RequestState.loading;
    emit(ReversionLoading());
    final result = await getAllReversionUsecases.call(
      status: status,
      serviceID: serviceID,
    );
    result.fold(
      (failure) {
        reversionRequestState = RequestState.error;
        emit(ReversionError(error: reversionRequestState));
      },
      (reversion) {
        reversionEntity = reversion;
        if ((reversion.data ?? []).isNotEmpty) {
          reversionRequestState = RequestState.loaded;
          emit(
            GetAllReversion(
              reversionEntity: reversion,
              reversionRequestState: reversionRequestState,
            ),
          );
        } else {
          reversionRequestState = RequestState.empty;
          emit(ReversionError(error: reversionRequestState));
        }
      },
    );
  }

  /// Confirms the reservation with this order code. Returns true on success;
  /// the caller decides what to do next (close the scanner, resume, ...).
  Future<bool> scanOrder({required String qrCode}) async {
    final code = qrCode.trim();
    if (code.isEmpty) return false;
    EasyLoading.show();
    final result = await scanOrderUsecases.call(qrCode: code);
    EasyLoading.dismiss();
    return result.fold(
      (failure) {
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
        return false;
      },
      (scan) {
        final success = scan.status == 200;
        showCustomSnackBar(
          scan.message ?? '',
          backgroundColor: success ? Colors.green : AppColors.darkRed,
        );
        return success;
      },
    );
  }
}
