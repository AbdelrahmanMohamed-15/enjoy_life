import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Reversion/Presentation/Widget/reversion_card.dart';
import 'package:easy_life/Features/Reversion/Presentation/cubit/reversion_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../Widget/reversion_service_type.dart';
import '../Widget/reversion_status.dart';

/// Reservations of a single service (restaurant, hotel or trip).
class ReversionListScreen extends StatelessWidget {
  final int serviceID;
  const ReversionListScreen({super.key, required this.serviceID});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<ReversionCubit, ReversionState>(
      builder: (context, state) {
        var reversionCubit = ReversionCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            title: Text(
              ReversionServiceType.title(serviceID),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 20,
                color: AppColors.primary500,
                fontFamily: BaseConstant.cairoBold,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.backgroundColor,
            leading: IconButton(
              onPressed: () => AppNavigation.pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.primary500,
                size: 20,
              ),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 6),
              ReversionStatus(
                status: reversionCubit.status,
                reversionCubit: reversionCubit,
              ),
              const SizedBox(height: 8),
              Expanded(
                child:
                    reversionCubit.reversionRequestState == RequestState.error
                    ? StateMessageWidget.error(
                        onRetry: () => reversionCubit.getAllReversion(),
                      )
                    : reversionCubit.reversionEntity == null ||
                          reversionCubit.reversionRequestState ==
                              RequestState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : reversionCubit.reversionRequestState == RequestState.empty
                    ? StateMessageWidget.empty(
                        message: LocaleKeys.reversionEmpty.tr(),
                        onRetry: () => reversionCubit.getAllReversion(),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                        itemCount: reversionCubit.reversionEntity!.data!.length,
                        itemBuilder: (context, index) => ReversionCard(
                          reversion:
                              reversionCubit.reversionEntity!.data![index],
                          serviceID: serviceID,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
