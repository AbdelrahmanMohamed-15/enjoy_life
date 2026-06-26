import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Reversion/Presentation/Widget/reversion_card.dart';
import 'package:easy_life/Features/Reversion/Presentation/Widget/reversion_service.dart';
import 'package:easy_life/Features/Reversion/Presentation/cubit/reversion_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../Widget/reversion_status.dart';

class ReversionScreen extends StatelessWidget {
  const ReversionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) =>
          DependencyInjectionHelper().sl<ReversionCubit>()..getAllReversion(),
      child: BlocBuilder<ReversionCubit, ReversionState>(
        builder: (context, state) {
          var reversionCubit = ReversionCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys.reversionTitle.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                  color: AppColors.primary500,
                ),
              ),
              centerTitle: true,
              elevation: 2,
            ),
            body: Column(
              children: [
                const SizedBox(height: 15),
                ReversionService(
                  serviceID: reversionCubit.serviceID,
                  reversionCubit: reversionCubit,
                ),
                const SizedBox(height: 15),
                ReversionStatus(
                  status: reversionCubit.status,
                  reversionCubit: reversionCubit,
                ),
                const SizedBox(height: 15),
                Expanded(
                  child:
                      reversionCubit.reversionEntity == null ||
                          reversionCubit.reversionRequestState ==
                              RequestState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : reversionCubit.reversionRequestState ==
                            RequestState.empty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetsStrings.empty),
                            const SizedBox(height: 20),
                            Center(
                              child: Text(
                                LocaleKeys.reversionEmpty.tr(),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 17,
                                  color: AppColors.black700,
                                ),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          itemCount:
                              reversionCubit.reversionEntity!.data!.length,
                          itemBuilder: (context, index) {
                            var reversion =
                                reversionCubit.reversionEntity!.data![index];
                            return ReversionCard(reversion: reversion);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
