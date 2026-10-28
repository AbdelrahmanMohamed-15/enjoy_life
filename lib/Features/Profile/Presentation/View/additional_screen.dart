import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Profile/Presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Widget/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';

class AdditionalScreen extends StatelessWidget {
  final String type;
  const AdditionalScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var profileCubit = ProfileCubit.get(context);
        final title = type == 'terms_of_use'
            ? LocaleKeys.profileTerms.tr()
            : type == 'privace_police'
            ? LocaleKeys.profilePrivacy.tr()
            : type == 'faq'
            ? LocaleKeys.profileFaq.tr()
            : LocaleKeys.supportTitle.tr();
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppPageBar(title: title),
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
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    children: [
                      AppCard(
                        padding: const EdgeInsets.all(18),
                        child: Html(
                          data:
                              profileCubit
                                  .additionalEntity
                                  ?.data
                                  ?.first
                                  .description ??
                              '',
                          style: {
                            "body": Style(
                              color: AppColors.natural600,
                              fontSize: FontSize(14),
                              lineHeight: const LineHeight(1.7),
                              margin: Margins.zero,
                              padding: HtmlPaddings.zero,
                              fontFamily: BaseConstant.cairoRegular,
                            ),
                            "p": Style(
                              margin: Margins.only(bottom: 10),
                              padding: HtmlPaddings.zero,
                            ),
                            "h1,h2,h3,h4,strong,b": Style(
                              color: AppColors.black700,
                              fontFamily: BaseConstant.cairoBold,
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
