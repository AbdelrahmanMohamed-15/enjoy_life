import 'package:flutter/material.dart';

class HotelItemModel {
  int? branchID;
  TextEditingController? roomNumber;
  TextEditingController? floorNumber;
  TextEditingController? capacity;
  TextEditingController? price;
  TextEditingController? deposit;

  HotelItemModel({
    this.branchID,
    TextEditingController? roomNumber,
    TextEditingController? floorNumber,
    TextEditingController? capacity,
    TextEditingController? price,
    TextEditingController? deposit,
  })  : roomNumber = roomNumber ?? TextEditingController(),
        floorNumber = floorNumber ?? TextEditingController(),
        capacity = capacity ?? TextEditingController(),
        price = price ?? TextEditingController(),
        deposit = deposit ?? TextEditingController();
}
