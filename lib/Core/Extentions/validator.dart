import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension Validator on String {

  String? noValidate() {
    return null;
  }


  String? validateEmpty(BuildContext context, {String? message}) {
    if (trim().isEmpty) {
      return message ?? tr('Field required');
    }
    return null;
  }

  String? validateLessThan(BuildContext context, double maxAmount, ) {
    if (trim().isEmpty) {
      return tr('Field The Hypex Required');
    }


    final doubleValue = double.tryParse(trim());
    if (doubleValue == null) {
      return tr('Invalid number');
    }

    if (doubleValue > maxAmount) {
      return tr('Must be less than ${maxAmount}', args: [maxAmount.toStringAsFixed(2)]); // Pass the maxAmount
    }

    return null; // Valid
  }
}
