import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/profile_cubit.dart';

void pickupBottomSheet({required ProfileCubit profileCubit}) {
  showImageSourceSheet(
    context: AppNavigation.globalContext,
    title: LocaleKeys.profilePickImageTitle.tr(),
    cameraLabel: LocaleKeys.profilePickCamera.tr(),
    galleryLabel: LocaleKeys.profilePickGallery.tr(),
    onPick: (fromCamera) => profileCubit.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    ),
  );
}
