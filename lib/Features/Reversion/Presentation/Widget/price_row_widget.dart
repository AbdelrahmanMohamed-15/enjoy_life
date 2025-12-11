import 'package:easy_life/Core/Extentions/padding_ext.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';

class PriceRowWidget extends StatelessWidget {
  final String title;
  final String price;
  const PriceRowWidget({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: BaseConstant.cairoBold,
              color: AppColors.black700,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '$price ج.م',
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.natural400,
            fontFamily: BaseConstant.cairoBold,
          ),
        ),
      ],
    ).setVerticalPadding(context, 4, enableMediaQuery: false);
  }
}
