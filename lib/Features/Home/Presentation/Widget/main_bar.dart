// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Helper/user_validation_helper.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';

import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Routes/app_routes.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_text_form_field.dart';

class MainBar extends StatelessWidget {
  final bool isHaveSearch;
  const MainBar({super.key, required this.isHaveSearch});

  @override
  Widget build(BuildContext context) {
    Userdata? userData = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getUserData();
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.natural100,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    UserValidationHelper.checkUserValidation() == true
                        ? 'مرحبا ${userData?.fullName ?? ''}'
                        : 'مرحبا زائر',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: AppColors.primary400,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    AppNavigation.pushNamed(AppRoutes.notification);
                  },
                  child: FaIcon(
                    FontAwesomeIcons.bell,
                    color: AppColors.black700,
                  ),
                ),
              ],
            ),
            if (isHaveSearch) ...[
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  AppNavigation.pushNamed(AppRoutes.search);
                },
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    controller: TextEditingController(),
                    hintText: 'ابحث عن مطعم، فندق أو رحلة',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: AppColors.primary400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ).setHorizontalPadding(context, 15, enableMediaQuery: false),
      ),
    );
  }
}
