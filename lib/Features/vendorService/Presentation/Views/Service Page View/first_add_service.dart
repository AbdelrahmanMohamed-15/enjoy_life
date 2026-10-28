import 'package:easy_life/Features/vendorService/Presentation/Views/add_branch_screen.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/language_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/name_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstAddService extends StatelessWidget {
  const FirstAddService({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const LanguageWidget(),
            NameWidget(formKey: vendorServiceCubit.formKey),
            VendorContactSection(vendorServiceCubit: vendorServiceCubit),
          ],
        );
      },
    );
  }
}
