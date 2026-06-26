import 'package:flutter/material.dart';

class TripScheduleItemModel {
  int? branchID;
  int? tripScheduleID;

  TextEditingController capacity;
  TextEditingController price;
  TextEditingController deposit;
  TextEditingController startPlace;
  TextEditingController endPlace;
  TextEditingController startDate;
  TextEditingController endDate;

  TripScheduleItemModel({
    this.branchID,
    this.tripScheduleID,
    TextEditingController? capacity,
    TextEditingController? price,
    TextEditingController? deposit,
    TextEditingController? startPlace,
    TextEditingController? endPlace,
    TextEditingController? startDate,
    TextEditingController? endDate,
  }) : capacity = capacity ?? TextEditingController(),
       price = price ?? TextEditingController(),
       deposit = deposit ?? TextEditingController(),
       startPlace = startPlace ?? TextEditingController(),
       endPlace = endPlace ?? TextEditingController(),
       startDate = startDate ?? TextEditingController(),
       endDate = endDate ?? TextEditingController();
}
