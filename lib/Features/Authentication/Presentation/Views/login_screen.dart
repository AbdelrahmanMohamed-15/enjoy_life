import 'package:easy_life/Core/Constant/assets_strings.dart';
import 'package:easy_life/Core/Extentions/center_ext.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Core/Widget/custom_text_form_field.dart';
import 'package:easy_life/Core/Widget/main_app_button.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_country_code.dart';

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
    var theme = Theme.of(context);
    var size = MediaQuery.sizeOf(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);
        return PopScope(
          // Guests reach this from inside the app and must be able to go back
          canPop: true,
          child: SafeArea(
            child: Scaffold(
              body: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  children: [
                    Image.asset(
                      AssetsStrings.appLogo,
                      height: 120,
                      width: size.width * 0.6,
                    ),
                    SizedBox(height: 20),
                    Text(
                      LocaleKeys.authLoginTitle.tr(),
                      style: theme.textTheme.headlineSmall!.copyWith(
                        color: AppColors.black700,
                      ),
                    ).setCenter(),
                    SizedBox(height: 50),
                    CustomTextFormField(
                      controller: authCubit.phoneController,
                      hintText: LocaleKeys.authLoginPhoneHint.tr(),
                      textInputType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.authLoginPhoneRequired.tr();
                        }
                        return null;
                      },
                      prefixIcon: CustomCountryCode(
                        onChanged: (value) {
                          debugPrint('Country selected ${value.dialCode}');
                          setState(() {
                            dailCode = value.dialCode ?? '+20';
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: authCubit.passwordController,
                      hintText: LocaleKeys.authLoginPasswordHint.tr(),
                      textInputType: TextInputType.visiblePassword,
                      obscureText: isObscure,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.authLoginPasswordRequired.tr();
                        }
                        if (value.length < 6) {
                          return LocaleKeys.authLoginPasswordMinLength.tr();
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          !isObscure ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.primary200,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            AppNavigation.pushNamed(AppRoutes.forgetPassword);
                          },
                          child: Text(
                            LocaleKeys.authLoginForgotPassword.tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.primary300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    MainAppButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authCubit.login(
                            dailCode: dailCode,
                            phone: authCubit.phoneController.text,
                            password: authCubit.passwordController.text,
                          );
                        }
                      },
                      child: Text(
                        LocaleKeys.authLoginButton.tr(),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.natural100,
                          fontFamily: BaseConstant.cairoBold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        AppNavigation.pushReplacementNamed(AppRoutes.register);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.authLoginNoAccount.tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.black700,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            LocaleKeys.authLoginCreateAccount.tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.primary500,
                            ),
                          ),
                        ],
                      ).setCenter(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
