import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Core/Helper/input_validator.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Routes/app_routes.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_country_code.dart';
import '../../../../Core/Widget/custom_text_form_field.dart';
import '../../../../Core/Widget/main_app_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          canPop: false,
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
                      'انشاء حساب جديد',
                      style: theme.textTheme.headlineSmall!.copyWith(
                        color: AppColors.black700,
                      ),
                    ).setCenter(),
                    SizedBox(height: 50),
                    CustomTextFormField(
                      controller: authCubit.nameController,
                      hintText: 'اسم المستخدم',
                      validator: (value) =>
                          InputValidator.validateNotEmpty(value),
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: authCubit.emailController,
                      hintText: 'البريد الالكتروني',
                      textInputType: TextInputType.emailAddress,
                      validator: (value) => InputValidator.validateEmail(value),
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: authCubit.regPhoneController,
                      hintText: 'رقم الجوال',
                      textInputType: TextInputType.phone,
                      validator: (value) =>
                          InputValidator.validateNotEmpty(value),
                      prefixIcon: CustomCountryCode(
                        onChanged: (value) {
                          debugPrint('Country selected ${value.dialCode}');
                          // authCubit.setCountryCode(code: value.dialCode!);
                          setState(() {
                            dailCode = value.dialCode ?? '+20';
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: authCubit.addressController,
                      hintText: 'العنوان',
                      validator: (value) =>
                          InputValidator.validateNotEmpty(value),
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: authCubit.regPasswordController,
                      hintText: 'كلمة المرور',
                      textInputType: TextInputType.visiblePassword,
                      obscureText: isObscure,
                      validator: (value) =>
                          InputValidator.validateNotEmpty(value),
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
                      controller: authCubit.confirmPasswordController,
                      hintText: 'تأكيد كلمة المرور',
                      textInputType: TextInputType.visiblePassword,
                      obscureText: isObscure2,
                      validator: (value) =>
                          InputValidator.validateConfirmPassword(
                            value,
                            authCubit.regPasswordController.text,
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
                        'انشاء حساب',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.natural100,
                          fontFamily: BaseConstant.cairoBold,
                        ),
                      ),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authCubit.register(
                            authCubit: authCubit,
                            dailCode: dailCode,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        AppNavigation.pushReplacementNamed(AppRoutes.login);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'لديك حساب بالفعل؟',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.black700,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'تسجيل الدخول',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.primary500,
                              fontFamily: BaseConstant.cairoBold,
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
