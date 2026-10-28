import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Profile/Presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Helper/input_validator.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_network_image.dart';
import '../../../../Core/Widget/custom_text_form_field.dart';
import '../../../../Core/Widget/main_app_button.dart';
import '../Widget/pick_bottom_sheet.dart';

class EditProfileScreen extends StatelessWidget {
  final VoidCallback onupdate;
  const EditProfileScreen({super.key, required this.onupdate});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var profileCubit = ProfileCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColors.natural100,
              title: Text(
                LocaleKeys.profileEditTitle.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.primary500,
                  fontFamily: BaseConstant.cairoBold,
                ),
              ),
              elevation: 1,
              leading: GestureDetector(
                onTap: () {
                  AppNavigation.pop();
                },
                child: Icon(Icons.arrow_back_ios, color: AppColors.primary500),
              ),
            ),
            body: Form(
              key: profileCubit.formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary500,
                                  width: 2,
                                ),
                                // image: DecorationImage(
                                //   image: NetworkImage(
                                //     '${BaseConstant.baseImage}${profileCubit.usermodel!.image ?? ''}',
                                //   ),
                                //   fit: BoxFit.fill,
                                // ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(50),
                                child: profileCubit.profileImage != null
                                    ? Image.file(
                                        profileCubit.profileImage!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      )
                                    : CustomNetworkImage(
                                        imageUrl: profileCubit.userData?.image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                        errorWidget: const Icon(
                                          Icons.person,
                                          size: 60,
                                          color: AppColors.primary400,
                                        ),
                                      ),
                              ),
                            ).setCenter(),
                            Positioned(
                              bottom: 2,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  pickupBottomSheet(profileCubit: profileCubit);
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary100,
                                    border: Border.all(
                                      color: AppColors.primary500,
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 16,
                                    color: AppColors.natural100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.profileEditAddPhoto.tr(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.black700,
                                fontFamily: BaseConstant.cairoBold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              LocaleKeys.profileEditPhotoHint.tr(),
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.natural400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  CustomTextFormField(
                    controller: profileCubit.nameController,
                    labelText: LocaleKeys.profileEditUsername.tr(),
                    // readOnly: true,
                    validator: (value) =>
                        InputValidator.validateNotEmpty(value),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: profileCubit.phoneController,
                    labelText: LocaleKeys.profileEditPhone.tr(),
                    readOnly: true,
                    validator: (value) =>
                        InputValidator.validateNotEmpty(value),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: profileCubit.emailController,
                    labelText: LocaleKeys.profileEditEmail.tr(),
                    readOnly: true,
                    validator: (value) =>
                        InputValidator.validateNotEmpty(value),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: profileCubit.addressController,
                    labelText: LocaleKeys.profileEditAddress.tr(),
                    validator: (value) =>
                        InputValidator.validateNotEmpty(value),
                  ),
                  const SizedBox(height: 40),
                  MainAppButton(
                    bgColor: AppColors.primary500,
                    onTap: () {
                      if (profileCubit.formKey.currentState!.validate()) {
                        profileCubit.updateProfile(onSuccess: onupdate);
                      }
                    },
                    child: Text(
                      LocaleKeys.profileEditSave.tr(),
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.natural100,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
