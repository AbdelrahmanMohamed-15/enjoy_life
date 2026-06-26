import 'package:easy_life/Core/Constant/assets_strings.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Extentions/padding_ext.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Services/Domain/Entity/room_entity.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Routes/app_navigation.dart';

class RoomScreen extends StatelessWidget {
  final String title;
  final ServiceCubit serviceCubit;
  final List<RoomData> tableData;
  final String startDate;
  final String endDate;
  const RoomScreen({
    super.key,
    required this.tableData,
    required this.title,
    required this.serviceCubit,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: Text(title),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              AppNavigation.pop();
            },
            child: Icon(Icons.arrow_back_ios, color: AppColors.primary400),
          ),
          actions: const [
            // Icon(Icons.favorite_border),
            // SizedBox(width: 12),
            Icon(Icons.share),
            SizedBox(width: 12),
          ],
        ),
        body: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          itemCount: tableData.length,
          separatorBuilder: (context, index) =>
              const Divider(color: AppColors.natural400),
          itemBuilder: (context, index) {
            var room = tableData[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    AssetsStrings.room,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: LocaleKeys.servicesRoomNumber.tr(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.primary400,
                                fontFamily: BaseConstant.cairoBold,
                              ),
                            ),
                            TextSpan(text: ' '),
                            TextSpan(
                              text: room.roomNumber,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.black700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: LocaleKeys.servicesCapacity.tr(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.primary400,
                                fontFamily: BaseConstant.cairoBold,
                              ),
                            ),
                            TextSpan(text: ' '),
                            TextSpan(
                              text: room.capacity.toString(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.black700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    debugPrint('rooms.data Function $startDate $endDate');
                    serviceCubit.addToCart(
                      type: 'room',
                      roomID: room.id!,
                      startDate: startDate,
                      endDate: endDate,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: AppColors.black700),
                    ),
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ).setVerticalPadding(context, 8, enableMediaQuery: false);
          },
        ),
      ),
    );
  }
}
