import 'package:easy_life/Core/Helper/safe_emit_mixin.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/Helper/base_entity.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:easy_life/Features/Profile/Domain/Entity/additional_entity.dart';
import 'package:easy_life/Features/Profile/Domain/Usecases/delete_account_usecases.dart';
import 'package:easy_life/Features/Profile/Domain/Usecases/get_profile_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../Domain/Entity/profile_entity.dart';
import '../../Domain/Usecases/get_additional_usecases.dart';
import '../../Domain/Usecases/update_profile_usecases.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> with SafeEmitMixin<ProfileState> {
  ProfileCubit({
    required this.getProfileUsecases,
    required this.updateProfileUsecases,
    required this.getAdditionalUsecases,
    required this.deleteAccountUsecases,
  }) : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  Userdata? userData = DependencyInjectionHelper()
      .sl<AuthHandlerInterface>()
      .getUserData();

  // varabile of usecases
  final GetProfileUsecases getProfileUsecases;
  final UpdateProfileUsecases updateProfileUsecases;
  final GetAdditionalUsecases getAdditionalUsecases;
  final DeleteAccountUsecases deleteAccountUsecases;

  // varaiable of entity
  ProfileEntity? profileEntity;
  AdditionalEntity? additionalEntity;
  RequestState profileRequestState = RequestState.loading;
  RequestState additionalRequestState = RequestState.loading;

  // varaiable of update profile
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  File? profileImage;

  refreshUserData() {
    userData = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getUserData();
    emit(SetUserDataSuccess(userdata: userData!));
  }

  getProfileData() async {
    emit(GetProfileLoading());
    final result = await getProfileUsecases.call();
    result.fold(
      (failure) {
        profileRequestState = RequestState.error;
        emit(GetProfileError(requestState: profileRequestState));
      },
      (profileEntity) {
        emit(GetProfileSuccess(profileEntity: profileEntity));
        Future.delayed(const Duration(milliseconds: 500), () async {
          await DependencyInjectionHelper()
              .sl<AuthHandlerInterface>()
              .setUserData(profileEntity.data);
          refreshUserData();
        });
      },
    );
  }

  Future<void> pickImage({required ImageSource source}) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: source, imageQuality: 70);
    if (image != null) {
      try {
        final file = File(image.path);
        profileImage = file;

        emit(ProfileImagePicked(image: file));
      } catch (e) {
        debugPrint('Error processing image: $e');
        // Handle error appropriately
      }
    }
  }

  initProfileData() {
    if (userData != null) {
      nameController.text = userData?.fullName ?? '';
      phoneController.text = userData?.phone ?? '';
      emailController.text = userData?.email ?? '';
      addressController.text = userData?.address ?? '';
    }
  }

  updateProfile({required VoidCallback onSuccess}) async {
    EasyLoading.show();

    Map<String, dynamic> body = {
      "full_name": nameController.text,
      "phone": phoneController.text,
      "email": emailController.text,
      "address": addressController.text,
    };

    if (profileImage != null) {
      body['image'] = await MultipartFile.fromFile(
        profileImage!.path,
        filename: profileImage!.path.split('/').last,
        contentType: MediaType(
          "image",
          "jpeg",
        ), // <-- requires `http_parser` package
      );
    }

    final formData = FormData.fromMap(body);

    final result = await updateProfileUsecases.call(formData: formData);

    result.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (profileEntity) async {
        await getProfileData();
        EasyLoading.dismiss();
        AppNavigation.pop();
        onSuccess();
        showCustomSnackBar(
          profileEntity.message ?? '',
          backgroundColor: AppColors.primary400,
        );
      },
    );
  }

  Future<void> getAdditionalPage({required String type}) async {
    additionalRequestState = RequestState.loading;
    emit(GetAdditionalPageLoading());
    final result = await getAdditionalUsecases.call(type: type);
    result.fold(
      (failure) {
        additionalRequestState = RequestState.error;
        emit(GetAdditionalPageError(requestState: additionalRequestState));
      },
      (additional) {
        additionalEntity = additional;
        if ((additional.data ?? []).isEmpty) {
          additionalRequestState = RequestState.empty;
          emit(GetAdditionalPageError(requestState: additionalRequestState));
        } else {
          additionalRequestState = RequestState.loaded;
          emit(GetAdditionalPageSuccess(additionalPageEntity: additional));
        }
      },
    );
  }

  Future<BaseEntity?> deleteAccount() async {
    EasyLoading.show();
    final res = await deleteAccountUsecases.call();
    return res.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
        return null;
      },
      (entity) {
        EasyLoading.dismiss();
        showCustomSnackBar(
          entity.message ?? '',
          backgroundColor: AppColors.primary400,
        );
        return entity;
      },
    );
  }
}
