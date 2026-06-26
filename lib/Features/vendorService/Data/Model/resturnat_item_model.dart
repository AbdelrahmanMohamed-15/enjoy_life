import 'package:flutter/material.dart';

class ResturnatItemModel {
  int? branchID;
  TextEditingController? tableNumber;
  TextEditingController? capacity;
  TextEditingController? price;
  TextEditingController? deposit;

  ResturnatItemModel({
    this.branchID,
    TextEditingController? tableNumber,
    TextEditingController? capacity,
    TextEditingController? price,
    TextEditingController? deposit,
  }) : tableNumber = tableNumber ?? TextEditingController(),
       capacity = capacity ?? TextEditingController(),
       price = price ?? TextEditingController(),
       deposit = deposit ?? TextEditingController();
}
