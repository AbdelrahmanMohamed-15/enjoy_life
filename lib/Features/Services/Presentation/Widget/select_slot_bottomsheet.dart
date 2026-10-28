import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/Helper/service_kind.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
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

  void _continue() {
    if (fromDate == null ||
        toTime == null ||
        fromTime == null ||
        toDate == null) {
      showCustomSnackBar(
        LocaleKeys.servicesBookingTimeRequired.tr(),
        backgroundColor: AppColors.darkRed,
      );
      return;
    }
    DateTime at(DateTime d, TimeOfDay t) =>
        DateTime(d.year, d.month, d.day, t.hour, t.minute);
    if (!at(toDate!, toTime!).isAfter(at(fromDate!, fromTime!))) {
      showCustomSnackBar(
        LocaleKeys.servicesBookingEndBeforeStart.tr(),
        backgroundColor: AppColors.darkRed,
      );
      return;
    }
    final startDate = '${formatDate(fromDate)} ${formatTime24(fromTime)}';
    final endDate = '${formatDate(toDate)} ${formatTime24(toTime)}';
    switch (ServiceKind.of(name: widget.type)) {
      case ServiceKind.restaurant:
        widget.serviceCubit.getAvaliableTables(
          resturantID: widget.serviceID,
          startDate: startDate,
          endDate: endDate,
          title: widget.title,
          serviceCubit: widget.serviceCubit,
        );
      case ServiceKind.hotel:
        widget.serviceCubit.getAvaliableRooms(
          hotelID: widget.serviceID,
          startDate: startDate,
          endDate: endDate,
          title: widget.title,
          serviceCubit: widget.serviceCubit,
        );
      case ServiceKind.trip:
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Widget row(String label, bool isFrom) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontFamily: BaseConstant.cairoBold,
            color: AppColors.natural600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: _buildInputBox(
                icon: Icons.calendar_month_rounded,
                text: formatDate(isFrom ? fromDate : toDate),
                onTap: () => _selectDate(context, isFrom),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: _buildInputBox(
                icon: Icons.schedule_rounded,
                text: formatTime(isFrom ? fromTime : toTime),
                onTap: () => _selectTime(context, isFrom),
              ),
            ),
          ],
        ),
      ],
    );
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.natural300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (ServiceKind.of(name: widget.type) case final kind?) ...[
                  BookingTypeIcon(itemType: kind.itemType, size: 40),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.servicesBookingTitle.tr(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontFamily: BaseConstant.cairoBold,
                          color: AppColors.black700,
                        ),
                      ),
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.natural500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            row(LocaleKeys.servicesBookingDateFrom.tr(), true),
            const SizedBox(height: 16),
            row(LocaleKeys.servicesBookingDateTo.tr(), false),
            const SizedBox(height: 28),
            AppGradientButton(
              label: LocaleKeys.servicesBookingContinue.tr(),
              icon: Icons.search_rounded,
              onTap: _continue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBox({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    final empty = text.isEmpty;
    return Material(
      color: empty
          ? AppColors.natural50
          : AppColors.primary100.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: empty ? AppColors.natural200 : AppColors.primary300,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: empty ? AppColors.natural500 : AppColors.primary600,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  empty ? LocaleKeys.commonSelect.tr() : text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: empty ? null : BaseConstant.cairoBold,
                    color: empty ? AppColors.natural500 : AppColors.black700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
