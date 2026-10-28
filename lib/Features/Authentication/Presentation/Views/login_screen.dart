import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/custom_text_form_field.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_country_code.dart';
import '../Widget/auth_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  String dailCode = '+20';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);
        return Form(
          key: _formKey,
          child: AuthLayout(
            title: LocaleKeys.authLoginTitle.tr(),
            subtitle: LocaleKeys.authLoginSubtitle.tr(),
            children: [
              CustomTextFormField(
                controller: authCubit.phoneController,
                hintText: LocaleKeys.authLoginPhoneHint.tr(),
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.authLoginPhoneRequired.tr();
                  }
                  return null;
                },
                prefixIcon: CustomCountryCode(
                  onChanged: (value) {
                    setState(() => dailCode = value.dialCode ?? '+20');
                  },
                ),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: authCubit.passwordController,
                hintText: LocaleKeys.authLoginPasswordHint.tr(),
                textInputType: TextInputType.visiblePassword,
                obscureText: isObscure,
                prefixIcon: const Icon(
                  Icons.lock_rounded,
                  color: AppColors.primary400,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.authLoginPasswordRequired.tr();
                  }
                  if (value.length < 6) {
                    return LocaleKeys.authLoginPasswordMinLength.tr();
                  }
                  return null;
                },
                suffixIcon: PasswordToggle(
                  obscured: isObscure,
                  onTap: () => setState(() => isObscure = !isObscure),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () =>
                      AppNavigation.pushNamed(AppRoutes.forgetPassword),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary600,
                  ),
                  child: Text(
                    LocaleKeys.authLoginForgotPassword.tr(),
                    style: const TextStyle(fontFamily: BaseConstant.cairoBold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              AppGradientButton(
                label: LocaleKeys.authLoginButton.tr(),
                icon: Icons.login_rounded,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    authCubit.login(
                      dailCode: dailCode,
                      phone: authCubit.phoneController.text.trim(),
                      password: authCubit.passwordController.text,
                    );
                  }
                },
              ),
            ],
            footer: AuthSwitchLink(
              text: LocaleKeys.authLoginNoAccount.tr(),
              action: LocaleKeys.authLoginCreateAccount.tr(),
              onTap: () =>
                  AppNavigation.pushReplacementNamed(AppRoutes.register),
            ),
          ),
        );
      },
    );
  }
}
