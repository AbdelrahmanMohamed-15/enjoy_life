import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Widget/global_widget/country_widget.dart';
import '../../Widget/global_widget/logo_widget.dart';
import '../../Widget/global_widget/service_image_widget.dart';
import '../../Widget/global_widget/status_widget.dart';

class SecondAddService extends StatelessWidget {
  final bool isEdit;
  const SecondAddService({super.key, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        // var vendorServiceCubit = VendorServiceCubit.get(context);
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: [
            LogoWidget(),
            ServiceImageWidget(isEdit: isEdit),
            CountryWidget(),
            StatusWidget(),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
