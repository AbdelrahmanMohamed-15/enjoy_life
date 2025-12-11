import 'package:easy_life/Features/vendorService/Presentation/Views/Service%20Page%20View/first_add_service.dart';
import 'package:easy_life/Features/vendorService/Presentation/Views/Service%20Page%20View/second_add_service.dart';
import 'package:easy_life/Features/vendorService/Presentation/Views/Service%20Page%20View/third_add_service.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/scroll_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Routes/app_navigation.dart';
import '../../../../../Core/Themes/app_colors.dart';

class MainAddServiceScreen extends StatelessWidget {
  final String type;
  final bool isEdit;
  final int? id;
  const MainAddServiceScreen({
    super.key,
    required this.type,
    required this.isEdit,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColors.natural100,
              title: Text(
                type == 'resturant'
                    ? 'اضافة مطعم'
                    : type == 'hotel'
                    ? 'اضافة فندق'
                    : 'اضافة رحلة',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.primary500,
                  fontFamily: BaseConstant.cairoBold,
                ),
              ),
              elevation: 1,
              leading: GestureDetector(
                onTap: () {
                  if (!context.mounted) return;
                  switch (vendorServiceCubit.currentPage) {
                    case 0:
                      if (AppNavigation.navigatorKey.currentState != null) {
                        AppNavigation.pop();
                      } else {
                        Navigator.of(context).pop();
                      }
                      break;
                    case 1:
                      if (vendorServiceCubit.pageController.hasClients) {
                        vendorServiceCubit.pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                      break;
                    case 2:
                      if (vendorServiceCubit.pageController.hasClients) {
                        vendorServiceCubit.pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                      break;
                  }
                },
                child: Icon(Icons.arrow_back_ios, color: AppColors.primary500),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: vendorServiceCubit.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      FirstAddService(),
                      SecondAddService(isEdit: isEdit),
                      ThirdAddService(type: type),
                    ],
                    onPageChanged: (value) {
                      vendorServiceCubit.setCurrentPage(page: value);
                    },
                  ),
                ),
                ScrollWidget(type: type, isEdit: isEdit, id: id),
              ],
            ),
          ),
        );
      },
    );
  }
}
