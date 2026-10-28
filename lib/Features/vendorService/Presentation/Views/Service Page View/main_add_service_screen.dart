import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/vendorService/Presentation/Views/Service%20Page%20View/first_add_service.dart';
import 'package:easy_life/Features/vendorService/Presentation/Views/Service%20Page%20View/second_add_service.dart';
import 'package:easy_life/Features/vendorService/Presentation/Views/Service%20Page%20View/third_add_service.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/scroll_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/vendor_form_kit.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
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

  String _titleForType() {
    if (isEdit) {
      final name = switch (type) {
        'resturant' => LocaleKeys.vendorTypeRestaurant.tr(),
        'hotel' => LocaleKeys.vendorTypeHotel.tr(),
        _ => LocaleKeys.vendorTypeTrip.tr(),
      };
      return '${LocaleKeys.commonEdit.tr()} $name';
    }
    switch (type) {
      case 'resturant':
        return LocaleKeys.vendorAddRestaurant.tr();
      case 'hotel':
        return LocaleKeys.vendorAddHotel.tr();
      default:
        return LocaleKeys.vendorAddTrip.tr();
    }
  }

  String _lastStepLabel() {
    switch (type) {
      case 'resturant':
        return LocaleKeys.vendorStepTables.tr();
      case 'hotel':
        return LocaleKeys.vendorStepRooms.tr();
      default:
        return LocaleKeys.vendorStepSchedules.tr();
    }
  }

  void _previousPage(VendorServiceCubit cubit) {
    if (cubit.pageController.hasClients) {
      cubit.pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        final isFirstPage = vendorServiceCubit.currentPage == 0;
        // System back steps back through the pages instead of leaving
        return PopScope(
          canPop: isFirstPage,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) _previousPage(vendorServiceCubit);
          },
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: VendorAppBar(
                title: _titleForType(),
                onBack: () => isFirstPage
                    ? AppNavigation.pop()
                    : _previousPage(vendorServiceCubit),
              ),
              body: Column(
                children: [
                  _StepIndicator(
                    currentStep: vendorServiceCubit.currentPage,
                    labels: [
                      LocaleKeys.vendorStepInfo.tr(),
                      LocaleKeys.vendorStepMedia.tr(),
                      _lastStepLabel(),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: vendorServiceCubit.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const FirstAddService(),
                        SecondAddService(isEdit: isEdit),
                        ThirdAddService(type: type),
                      ],
                      onPageChanged: (value) {
                        vendorServiceCubit.setCurrentPage(page: value);
                      },
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: ScrollWidget(
                type: type,
                isEdit: isEdit,
                id: id,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> labels;
  const _StepIndicator({required this.currentStep, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < labels.length; i++) ...[
            if (i > 0)
              Expanded(
                child: Container(
                  height: 3,
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: i <= currentStep
                        ? AppColors.primary500
                        : AppColors.natural200,
                  ),
                ),
              ),
            _Step(
              index: i,
              label: labels[i],
              isDone: i < currentStep,
              isCurrent: i == currentStep,
            ),
          ],
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final int index;
  final String label;
  final bool isDone;
  final bool isCurrent;
  const _Step({
    required this.index,
    required this.label,
    required this.isDone,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final active = isDone || isCurrent;
    return SizedBox(
      width: 64,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 32,
            width: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: active
                  ? const LinearGradient(
                      colors: [AppColors.primary400, AppColors.primary600],
                    )
                  : null,
              color: active ? null : Colors.white,
              border: active
                  ? null
                  : Border.all(color: AppColors.natural300, width: 1.5),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: AppColors.primary500.withValues(alpha: 0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: isDone
                ? const Icon(Icons.check_rounded, size: 18, color: Colors.white)
                : Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: BaseConstant.cairoBold,
                      color: active ? Colors.white : AppColors.natural500,
                    ),
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: BaseConstant.cairoBold,
              color: active ? AppColors.primary700 : AppColors.natural500,
            ),
          ),
        ],
      ),
    );
  }
}
