import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Profile/Presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Themes/app_colors.dart';

class AdditionalScreen extends StatelessWidget {
  final String type;
  const AdditionalScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var profileCubit = ProfileCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColors.natural100,
              title: Text(
                type == 'terms_of_use'
                    ? LocaleKeys.profileTerms.tr()
                    : type == 'privace_police'
                    ? LocaleKeys.profilePrivacy.tr()
                    : type == 'faq'
                    ? LocaleKeys.profileFaq.tr()
                    : LocaleKeys.supportTitle.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.primary500,
                  fontFamily: BaseConstant.cairoBold,
                ),
              ),
              elevation: 1,
              leading: GestureDetector(
                onTap: () {
                  AppNavigation.pop();
                },
                child: Icon(Icons.arrow_back_ios, color: AppColors.primary500),
              ),
            ),
            body: profileCubit.additionalRequestState == RequestState.error
                ? StateMessageWidget.error(
                    onRetry: () => profileCubit.getAdditionalPage(type: type),
                  )
                : profileCubit.additionalEntity == null ||
                      profileCubit.additionalRequestState ==
                          RequestState.loading
                ? const Center(child: CircularProgressIndicator())
                : profileCubit.additionalRequestState == RequestState.empty
                ? StateMessageWidget.empty(
                    message: LocaleKeys.profileAdditionalEmpty.tr(),
                  )
                : ListView(
                    padding: const EdgeInsets.all(15),
                    children: [
                      Html(
                        data:
                            profileCubit
                                .additionalEntity
                                ?.data
                                ?.first
                                .description ??
                            '',
                        style: {
                          "body": Style(
                            color: AppColors.natural400,
                            fontSize: FontSize(12),
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                            fontFamily: BaseConstant.cairoBold,
                          ),
                          "p": Style(
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                            color: AppColors.natural400,
                            fontFamily: BaseConstant.cairoRegular,
                          ),
                        },
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
