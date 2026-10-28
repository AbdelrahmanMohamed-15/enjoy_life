import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

/// Camera / gallery chooser for the vendor logo ([type] 'logo') or the
/// listing images.
void pickuVendorpBottomSheet({
  VendorServiceCubit? vendorServiceCubit,
  required String type,
  Function()? onCameraTap,
  Function()? onGalleryTap,
}) {
  showImageSourceSheet(
    context: AppNavigation.globalContext,
    title: LocaleKeys.vendorPickImageTitle.tr(),
    cameraLabel: LocaleKeys.vendorPickCamera.tr(),
    galleryLabel: LocaleKeys.vendorPickGallery.tr(),
    onPick: (fromCamera) {
      final custom = fromCamera ? onCameraTap : onGalleryTap;
      if (custom != null) return custom();
      final source = fromCamera ? ImageSource.camera : ImageSource.gallery;
      if (type == 'logo') {
        vendorServiceCubit?.pickLogoFile(source: source);
      } else {
        vendorServiceCubit?.pickFile(source: source);
      }
    },
  );
}
