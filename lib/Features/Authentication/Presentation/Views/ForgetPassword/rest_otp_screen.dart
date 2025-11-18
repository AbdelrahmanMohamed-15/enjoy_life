import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../../../Core/Constant/assets_strings.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Routes/app_navigation.dart';
import '../../../../../Core/Themes/app_colors.dart';
import '../../../../../Core/Widget/main_app_button.dart';

class RestOtpScreen extends StatefulWidget {
  final AuthCubit authCubit;
  final bool isRegister;
  const RestOtpScreen({
    super.key,
    required this.authCubit,
    required this.isRegister,
  });

  @override
  State<RestOtpScreen> createState() => _RestOtpScreenState();
}

class _RestOtpScreenState extends State<RestOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text('التحقق من الكود'),
            leading: GestureDetector(
              onTap: () {
                AppNavigation.pop();
                widget.authCubit.emailRestController.clear();
                widget.authCubit.newPasswordController.clear();
                widget.authCubit.confirmPasswordController.clear();
              },
              child: Icon(Icons.arrow_back_ios, color: AppColors.primary400),
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
                  'التحقق من الكود',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: AppColors.black700,
                  ),
                ).setCenter(),
                SizedBox(height: 50),
                Pinput(
                      length: 6,
                      controller: widget.authCubit.otpRestController,
                      focusedPinTheme: PinTheme(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.primary400,
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجى إدخال الكود';
                        }
                        if (value.length != 6) {
                          return 'يرجى إدخال كود صحيح';
                        }
                        return null;
                      },
                    )
                    .setVerticalPadding(context, 35, enableMediaQuery: false)
                    .setCenter(),
                SizedBox(height: 20),
                MainAppButton(
                  child: Text(
                    widget.isRegister == false
                        ? 'استعادة كلمة المرور'
                        : 'تفعيل الحساب',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: AppColors.natural100,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isRegister == false) {
                        widget.authCubit.resetPassword();
                      } else {
                        widget.authCubit.activeEmail();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
