import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Core/Helper/input_validator.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Constant/assets_strings.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Routes/app_navigation.dart';
import '../../../../../Core/Themes/app_colors.dart';
import '../../../../../Core/Widget/custom_text_form_field.dart';
import '../../../../../Core/Widget/main_app_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool isObscure2 = true;
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
              appBar: AppBar(
                elevation: 0,
                title: Text(LocaleKeys.authForgotAppBar.tr()),
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    AppNavigation.pop();
                    authCubit.emailRestController.clear();
                    authCubit.newPasswordController.clear();
                    authCubit.confirmRestPasswordController.clear();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primary400,
                  ),
                ),
              ),
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
                      LocaleKeys.authForgotTitle.tr(),
                      style: theme.textTheme.headlineSmall!.copyWith(
                        color: AppColors.black700,
                      ),
                    ).setCenter(),
                    SizedBox(height: 50),
                    CustomTextFormField(
                      controller: authCubit.emailRestController,
                      hintText: LocaleKeys.authForgotEmailHint.tr(),
                      validator: (value) => InputValidator.validateEmail(value),
                    ),

                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: authCubit.newPasswordController,
                      hintText: LocaleKeys.authForgotPasswordHint.tr(),
                      textInputType: TextInputType.visiblePassword,
                      obscureText: isObscure,
                      validator: (value) =>
                          InputValidator.validatePassword(value),
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
                    CustomTextFormField(
                      controller: authCubit.confirmRestPasswordController,
                      hintText: LocaleKeys.authForgotConfirmHint.tr(),
                      textInputType: TextInputType.visiblePassword,
                      obscureText: isObscure2,
                      validator: (value) =>
                          InputValidator.validateConfirmPassword(
                            value,
                            authCubit.newPasswordController.text,
                          ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          !isObscure2 ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.primary200,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure2 = !isObscure2;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    MainAppButton(
                      child: Text(
                        LocaleKeys.authForgotButton.tr(),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.natural100,
                          fontFamily: BaseConstant.cairoBold,
                        ),
                      ),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authCubit.forgetPassword(authCubit: authCubit);
                        }
                      },
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
