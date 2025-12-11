import 'package:easy_life/Features/Reversion/Domain/Entities/reversion_entity.dart';
import 'package:easy_life/Features/Reversion/Presentation/Widget/main_reversion_card.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../Widget/price_row_widget.dart';
import '../Widget/reversion_service_card.dart';
import '../Widget/reversion_user_card.dart';

class ReversionDetailsScreen extends StatelessWidget {
  final ReversionData reversionData;
  const ReversionDetailsScreen({super.key, required this.reversionData});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.natural100,
          title: Text(
            'تفاصيل الحجز',
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
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            MainReversionCard(reversion: reversionData),
            ReversionUserCard(reversion: reversionData),
            const SizedBox(height: 20),
            Text(
              'الخدمات',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.primary500,
                fontFamily: BaseConstant.cairoBold,
              ),
            ),
            const SizedBox(height: 20),
            ...reversionData.orderDetails!.map(
              (e) => ReversionServiceCard(
                image: e.serviceBranch?.image,
                name: e.serviceBranch?.name,
                price: e.totalPrice,
              ),
            ),
            const SizedBox(height: 30),
            PriceRowWidget(
              title: 'السعر',
              price: reversionData.order?.totalPrice ?? '0.0',
            ),
            PriceRowWidget(
              title: 'مصاريف الشحن',
              price: reversionData.order?.shippingFees ?? '0.0',
            ),
            PriceRowWidget(
              title: 'الضريبة',
              price: reversionData.order?.taxesFees ?? '0.0',
            ),
            PriceRowWidget(
              title: 'الخصم',
              price: reversionData.order?.couponDiscount ?? '0.0',
            ),
            Divider(color: AppColors.natural400),
            PriceRowWidget(
              title: 'الاجمالي',
              price: reversionData.order?.totalPrice ?? '0.0',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
