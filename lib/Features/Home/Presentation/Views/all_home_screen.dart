import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import '../Widget/service_actions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Enums/level_message_enums.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Routes/app_routes.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/general_service_card.dart';
import '../../../Authentication/Domain/Entity/user_entity.dart';

class AllHomeScreen extends StatelessWidget {
  final String type;
  const AllHomeScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width ~/ 180;
    var theme = Theme.of(context);
    Userdata? userData = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getUserData();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.homeAllTitle.tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.primary400,
                fontFamily: BaseConstant.cairoBold,
                fontSize: 20,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                AppNavigation.pop();
              },
              child: Icon(Icons.arrow_back_ios, color: AppColors.primary400),
            ),
            centerTitle: true,
            elevation: 2,
          ),
          body: homeCubit.totalHomeRequestState == RequestState.error
              ? StateMessageWidget.error(
                  onRetry: () => homeCubit.getAllHome(type: type),
                )
              : homeCubit.totalHomeEntity == null ||
                    homeCubit.totalHomeRequestState == RequestState.loading
              ? const Center(child: CircularProgressIndicator())
              : homeCubit.totalHomeRequestState == RequestState.empty
              ? StateMessageWidget.empty()
              : GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisExtent: 250,
                    // childAspectRatio: 3 / 2,
                    // mainAxisSpacing: 10.0,
                    // crossAxisSpacing: 10.0,
                  ),
                  itemCount: homeCubit.totalHomeEntity!.data!.length,
                  itemBuilder: (context, index) {
                    var data = homeCubit.totalHomeEntity!.data![index];
                    return Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => ServiceActions.open(data),
                        child:
                            GeneralServiceCard(
                              logo: data.logo ?? '',
                              title: data.name ?? '',
                              isFavourite: data.isFavourite ?? false,
                              rate: data.rating ?? '0.0',
                              serviceName: data.serviceName ?? '',
                              description: data.description ?? '',
                              address: data.address ?? '',
                              addFavouriteTap: () =>
                                  ServiceActions.setFavourite(
                                    homeCubit,
                                    data,
                                    true,
                                  ),
                              removeFavouriteTap: () =>
                                  ServiceActions.setFavourite(
                                    homeCubit,
                                    data,
                                    false,
                                  ),
                            ).setHorizontalPadding(
                              context,
                              8,
                              enableMediaQuery: false,
                            ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
