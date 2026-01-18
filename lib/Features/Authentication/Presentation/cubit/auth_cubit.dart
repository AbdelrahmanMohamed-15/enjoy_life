import 'package:easy_life/Core/Handler/auth_handler.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:easy_life/Features/Authentication/Domain/UseCases/active_email_usecases.dart';
import 'package:easy_life/Features/Authentication/Domain/UseCases/forget_password_usecases.dart';
import 'package:easy_life/Features/Authentication/Domain/UseCases/register_usecases.dart';
import 'package:easy_life/Features/Authentication/Domain/UseCases/verify_reset_otp_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_life/Features/Authentication/Domain/UseCases/login_usecases.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../Domain/UseCases/rest_password_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecases loginUsecases;
  final ForgetPasswordUsecases forgetPasswordUsecases;
  final VerifyResetOtpUsecases verifyResetOtpUsecases;
  final RestPasswordUsecase restPasswordUsecase;
  final RegisterUsecases registerUsecases;
  final ActiveEmailUsecases activeEmailUsecases;

  AuthCubit({
    required this.loginUsecases,
    required this.forgetPasswordUsecases,
    required this.verifyResetOtpUsecases,
    required this.restPasswordUsecase,
    required this.registerUsecases,
    required this.activeEmailUsecases,
  }) : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  final DependencyInjectionHelper _di = DependencyInjectionHelper();
  // Varibal for Login
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Varibal for Register
  TextEditingController regPhoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Varibal for ForgetPassword
  TextEditingController emailRestController = TextEditingController();
  TextEditingController otpRestController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmRestPasswordController = TextEditingController();

  Future<void> login({
    required String dailCode,
    required String phone,
    required String password,
  }) async {
    EasyLoading.show();
    final result = await loginUsecases.call(
      dailCode: dailCode,
      phone: phone,
      password: password,
    );

    result.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (userEntity) {
        EasyLoading.dismiss();
        if (userEntity.status == true) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _di.sl<AuthHandlerInterface>().setToken(
              userEntity.data!.token!.original!.accessToken!,
            );
            _di.sl<AuthHandlerInterface>().setUserData(
              userEntity.data!.userdata,
            );

            AppNavigation.pushReplacementNamed(AppRoutes.mainNav);
            showCustomSnackBar(
              userEntity.message ?? '',
              backgroundColor: AppColors.primary400,
            );
          });
        } else {
          showCustomSnackBar(
            userEntity.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  register({required AuthCubit authCubit, required String dailCode}) async {
    EasyLoading.show();
    final result = await registerUsecases.call(
      dailCode: dailCode,
      name: nameController.text,
      email: emailController.text,
      phone: regPhoneController.text,
      password: regPasswordController.text,
      confirmPassword: confirmPasswordController.text,
      address: addressController.text,
    );
    result.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (register) {
        EasyLoading.dismiss();
        if (register.status == 200) {
          showCustomSnackBar(
            register.message ?? '',
            backgroundColor: AppColors.primary400,
          );
          AppNavigation.pushNamed(
            AppRoutes.verifyResetOtp,
            arguments: {"authCubit": authCubit, 'isRegister': true},
          );
        } else {
          showCustomSnackBar(
            register.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  activeEmail() async {
    EasyLoading.show();
    final result = await activeEmailUsecases.call(
      email: emailController.text,
      code: otpRestController.text,
    );
    result.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (base) {
        EasyLoading.dismiss();
        if (base.status == 200) {
          AppNavigation.pushNamedAndRemoveUntil(AppRoutes.login);
          showCustomSnackBar(
            base.message ?? '',
            backgroundColor: AppColors.primary400,
          );
          regPhoneController.clear();
          nameController.clear();
          emailController.clear();
          regPasswordController.clear();
          confirmPasswordController.clear();
          addressController.clear();
        } else {
          showCustomSnackBar(
            base.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  Future<void> forgetPassword({required AuthCubit authCubit}) async {
    EasyLoading.show();
    final result = await forgetPasswordUsecases.call(
      email: emailRestController.text,
    );
    result.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (base) {
        EasyLoading.dismiss();
        if (base.status == 200) {
          AppNavigation.pushNamed(
            AppRoutes.verifyResetOtp,
            arguments: {"authCubit": authCubit, 'isRegister': false},
          );
          showCustomSnackBar(
            base.message ?? '',
            backgroundColor: AppColors.primary400,
          );
        } else {
          showCustomSnackBar(
            base.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  Future<void> verifyResetOtp() async {
    EasyLoading.show();
    final result = await verifyResetOtpUsecases.call(
      email: emailRestController.text,
      otp: otpRestController.text,
    );
    result.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (userEntity) {
        EasyLoading.dismiss();
        if (userEntity.status == 200) {
          showCustomSnackBar(
            userEntity.message ?? '',
            backgroundColor: AppColors.primary400,
          );
          resetPassword();
        } else {
          showCustomSnackBar(
            userEntity.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  Future<void> resetPassword() async {
    EasyLoading.show();
    final result = await restPasswordUsecase.call(
      email: emailRestController.text,
      newPassword: newPasswordController.text,
      confirmPassword: confirmRestPasswordController.text,
    );
    result.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (userEntity) {
        EasyLoading.dismiss();
        if (userEntity.status == 200) {
          AppNavigation.pushNamedAndRemoveUntil(AppRoutes.login);
          showCustomSnackBar(
            userEntity.message ?? '',
            backgroundColor: AppColors.primary400,
          );
        } else {
          showCustomSnackBar(
            userEntity.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }
}
