import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Widget/global_widget/country_widget.dart';
import '../../Widget/global_widget/logo_widget.dart';
import '../../Widget/global_widget/service_image_widget.dart';
import '../../Widget/global_widget/status_widget.dart';
import '../../Widget/global_widget/vendor_form_kit.dart';

class SecondAddService extends StatelessWidget {
  final bool isEdit;
  const SecondAddService({super.key, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            VendorSectionCard(
              icon: Icons.photo_library_rounded,
              title: LocaleKeys.vendorSectionMedia.tr(),
              child: Column(
                children: [
                  const LogoWidget(),
                  ServiceImageWidget(isEdit: isEdit),
                ],
              ),
            ),
            VendorSectionCard(
              icon: Icons.tune_rounded,
              title: LocaleKeys.vendorSectionSettings.tr(),
              child: const Column(children: [CountryWidget(), StatusWidget()]),
            ),
          ],
        );
      },
    );
  }
}
