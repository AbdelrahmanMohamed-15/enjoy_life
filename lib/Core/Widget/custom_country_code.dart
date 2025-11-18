import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import '../Constant/base_constant.dart';
import '../Themes/app_colors.dart';

class CustomCountryCode extends StatelessWidget {
  final Function(CountryCode)? onChanged;
  const CustomCountryCode({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: 110,
      child: CountryCodePicker(
        initialSelection: 'EG',
        showCountryOnly: false,
        dialogSize: Size(size.width * 0.9, size.height * 0.5),
        searchPadding: EdgeInsetsGeometry.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        padding: EdgeInsetsGeometry.symmetric(horizontal: 0),
        flagWidth: 30,
        // enabled: false,
        textStyle: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.black700,
          fontFamily: BaseConstant.cairoBold,
        ),
        dialogTextStyle: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.black700,
          fontFamily: BaseConstant.cairoBold,
        ),
        alignLeft: true,
        onChanged: onChanged,
        flagDecoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
        pickerStyle: PickerStyle.bottomSheet,
      ),
    );
  }
}
