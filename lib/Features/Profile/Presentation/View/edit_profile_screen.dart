import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Profile/Presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Helper/input_validator.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/app_ui.dart';
import '../Widget/profile_avatar.dart';
import '../../../../Core/Widget/custom_text_form_field.dart';
import '../Widget/pick_bottom_sheet.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var profileCubit = ProfileCubit.get(context);
        Widget field({
          required TextEditingController controller,
          required String label,
          required IconData icon,
          bool readOnly = false,
        }) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 14),
              child: Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: AppColors.natural600,
                  fontSize: 13,
                ),
              ),
            ),
            CustomTextFormField(
              controller: controller,
              readOnly: readOnly,
              fillColor: readOnly ? AppColors.natural50 : null,
              prefixIcon: Icon(icon, color: AppColors.primary400),
              suffixIcon: readOnly
                  ? const Icon(
                      Icons.lock_outline_rounded,
                      size: 18,
                      color: AppColors.natural400,
                    )
                  : null,
              validator: (value) => InputValidator.validateNotEmpty(value),
            ),
          ],
        );
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppPageBar(title: LocaleKeys.profileEditTitle.tr()),
          body: Form(
            key: profileCubit.formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () => pickupBottomSheet(profileCubit: profileCubit),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary300,
                                AppColors.primary600,
                              ],
                            ),
                          ),
                          child: profileCubit.profileImage != null
                              ? ClipOval(
                                  child: Image.file(
                                    profileCubit.profileImage!,
                                    width: 108,
                                    height: 108,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ProfileAvatar(
                                  imageUrl: profileCubit.userData?.image,
                                  name: profileCubit.userData?.fullName,
                                  size: 108,
                                  borderWidth: 3,
                                ),
                        ),
                        PositionedDirectional(
                          bottom: 2,
                          end: 2,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary500,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.photo_camera_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  LocaleKeys.profileEditAddPhoto.tr(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.black700,
                    fontFamily: BaseConstant.cairoBold,
                  ),
                ),
                Text(
                  LocaleKeys.profileEditPhotoHint.tr(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.natural500,
                  ),
                ),
                const SizedBox(height: 20),
                AppCard(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
                  child: Column(
                    children: [
                      field(
                        controller: profileCubit.nameController,
                        label: LocaleKeys.profileEditUsername.tr(),
                        icon: Icons.person_rounded,
                      ),
                      field(
                        controller: profileCubit.phoneController,
                        label: LocaleKeys.profileEditPhone.tr(),
                        icon: Icons.phone_rounded,
                        readOnly: true,
                      ),
                      field(
                        controller: profileCubit.emailController,
                        label: LocaleKeys.profileEditEmail.tr(),
                        icon: Icons.alternate_email_rounded,
                        readOnly: true,
                      ),
                      field(
                        controller: profileCubit.addressController,
                        label: LocaleKeys.profileEditAddress.tr(),
                        icon: Icons.location_on_rounded,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: AppGradientButton(
                label: LocaleKeys.profileEditSave.tr(),
                icon: Icons.check_circle_rounded,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (profileCubit.formKey.currentState!.validate()) {
                    profileCubit.updateProfile();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
