import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:easy_life/Core/Widget/main_app_button.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:flutter/material.dart';

class BookingTimeBottomSheet extends StatefulWidget {
  final int serviceID;
  final String title;
  final String type;
  final ServiceCubit serviceCubit;
  const BookingTimeBottomSheet({
    super.key,
    required this.serviceID,
    required this.title,
    required this.type,
    required this.serviceCubit,
  });

  @override
  State<BookingTimeBottomSheet> createState() => _BookingTimeBottomSheetState();
}

class _BookingTimeBottomSheetState extends State<BookingTimeBottomSheet> {
  DateTime? fromDate;
  TimeOfDay? fromTime;
  DateTime? toDate;
  TimeOfDay? toTime;

  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  AppColors.primary400, // ✅ Header background & selected date
              onPrimary: Colors.white, // ✅ Header text & selected date text
              onSurface: Colors.black, // ✅ Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    AppColors.primary400, // ✅ "OK" and "CANCEL" buttons
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromTime = picked;
        } else {
          toTime = picked;
        }
      });
    }
    debugPrint("Time: $toTime");
  }

  String formatDate(DateTime? date) {
    if (date == null) return "";
    final String year = date.year.toString();
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    return "$year-$month-$day";
  }

  String formatTime(TimeOfDay? time) {
    if (time == null) return "";
    return time.format(context);
  }

  String formatTime24(TimeOfDay? time) {
    if (time == null) return "";
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final String hour = dt.hour.toString().padLeft(2, '0');
    final String minute = dt.minute.toString().padLeft(2, '0');
    return "$hour:$minute"; // e.g. 14:30
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // RTL support for Arabic
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // From date/time
              const Text("التاريخ من"),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(context, true),
                            child: _buildInputBox(
                              icon: Icons.calendar_today,
                              text: formatDate(fromDate),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectTime(context, true),
                            child: _buildInputBox(
                              icon: Icons.access_time,
                              text: formatTime(fromTime),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // To date/time
              const Text("التاريخ الى"),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(context, false),
                            child: _buildInputBox(
                              icon: Icons.calendar_today,
                              text: formatDate(toDate),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectTime(context, false),
                            child: _buildInputBox(
                              icon: Icons.access_time,
                              text: formatTime(toTime),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              // Continue button
              MainAppButton(
                bgColor: AppColors.primary400,
                child: const Text(
                  "أستمر",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  if (fromDate == null ||
                      toTime == null ||
                      fromTime == null ||
                      toDate == null) {
                    showCustomSnackBar(
                      'الرجاء اختيار التوقيت',
                      backgroundColor: AppColors.darkRed,
                    );
                  } else {
                    if (widget.type == 'Restaurant'.toUpperCase() ||
                        widget.type == 'مطعم') {
                      widget.serviceCubit.getAvaliableTables(
                        resturantID: widget.serviceID,
                        startDate:
                            '${formatDate(fromDate)} ${formatTime24(fromTime)}',
                        endDate:
                            '${formatDate(toDate)} ${formatTime24(toTime)}',
                        title: widget.title,
                        serviceCubit: widget.serviceCubit,
                      );
                    } else if (widget.type == 'Hotel'.toUpperCase() ||
                        widget.type == 'فندق') {
                      widget.serviceCubit.getAvaliableRooms(
                        hotelID: widget.serviceID,
                        startDate:
                            '${formatDate(fromDate)} ${formatTime24(fromTime)}',
                        endDate:
                            '${formatDate(toDate)} ${formatTime24(toTime)}',
                        title: widget.title,
                        serviceCubit: widget.serviceCubit,
                      );
                    } else if (widget.type == 'Trip'.toUpperCase() ||
                        widget.type == 'رحلة') {}
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputBox({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text.isEmpty ? "اختر" : text,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
