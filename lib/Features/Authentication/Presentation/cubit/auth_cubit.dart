import 'package:easy_life/Core/Handler/auth_handler.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_life/Features/Authentication/Domain/UseCases/login_usecases.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecases loginUsecases;

  AuthCubit({required this.loginUsecases}) : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  final DependencyInjectionHelper _di = DependencyInjectionHelper();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController regPhoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
              backgroundColor: AppColors.primary300,
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

  void clearControllers() {
    phoneController.clear();
    passwordController.clear();
    regPhoneController.clear();
    nameController.clear();
    emailController.clear();
    regPasswordController.clear();
    confirmPasswordController.clear();
    addressController.clear();
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    passwordController.dispose();
    regPhoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    regPasswordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    return super.close();
  }
}
