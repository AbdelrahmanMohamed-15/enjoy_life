import 'package:easy_life/Core/Helper/safe_emit_mixin.dart';
import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/Routes/routes.dart';
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:easy_life/Features/Reversion/Domain/Entities/reversion_entity.dart';
import 'package:easy_life/Features/Reversion/Domain/Usecases/get_all_reversion_usecases.dart';
import 'package:easy_life/Features/Reversion/Domain/Usecases/scan_order_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../Core/Themes/app_colors.dart';
part 'reversion_state.dart';

class ReversionCubit extends Cubit<ReversionState> with SafeEmitMixin<ReversionState> {
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
  bool isScanned = false;

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

  scanOrder({required String qrCode}) async {
    EasyLoading.show();
    final result = await scanOrderUsecases.call(qrCode: qrCode);
    result.fold(
      (failure) {
        EasyLoading.dismiss();
        isScanned = false; // Reset flag on error to allow retry
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (scan) {
        EasyLoading.dismiss();
        if (scan.status == 200) {
          showCustomSnackBar(scan.message ?? '', backgroundColor: Colors.green);
          if (AppNavigation.navigatorKey.currentState != null) {
            AppNavigation.pop();
          }
        } else {
          isScanned = false; // Reset flag on error to allow retry
          showCustomSnackBar(
            scan.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  void onDetect(BarcodeCapture capture) async {
    if (isScanned) return;
    if (capture.barcodes.isEmpty) return;

    final rawValue = capture.barcodes.first.rawValue;
    if (rawValue != null && rawValue.isNotEmpty) {
      // Set flag immediately to prevent multiple calls
      isScanned = true;
      try {
        debugPrint('Valid QR Code : $rawValue');
        await scanOrder(qrCode: rawValue);
      } catch (e) {
        isScanned = false; // Reset flag on error to allow retry
        showCustomSnackBar(e.toString(), backgroundColor: AppColors.darkRed);
        debugPrint('Invalid QR Code JSON: $e');
      }
    }
  }

  void resetScanFlag() {
    isScanned = false;
  }
}
