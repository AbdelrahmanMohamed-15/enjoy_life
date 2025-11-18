import 'package:flutter/material.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../Domain/Entity/order_history_entity.dart';

class OrderCard extends StatelessWidget {
  final OrderHistoryData order;

  const OrderCard({super.key, required this.order});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Order header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "رقم الطلب: ${order.orderCode}",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontFamily: BaseConstant.cairoBold,
                    color: AppColors.black700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(order.status ?? "").withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    order.status ?? "",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _statusColor(order.status ?? ""),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Customer info
            Text(
              "العميل: ${order.clientName ?? ''}",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: BaseConstant.cairoBold,
                color: AppColors.natural400,
              ),
            ),
            Text(
              "العنوان: ${order.address ?? ''}",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: BaseConstant.cairoBold,
                color: AppColors.natural300,
              ),
            ),
            Text(
              "طريقة الدفع: ${order.paymentType ?? ''}",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: BaseConstant.cairoBold,
                color: AppColors.natural300,
              ),
            ),

            const Divider(height: 20),

            /// Items list
            Text(
              "العناصر:",
              style: theme.textTheme.titleSmall?.copyWith(
                fontFamily: BaseConstant.cairoBold,
              ),
            ),
            const SizedBox(height: 6),

            ...order.items!.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${item.name} - ${item.price} ج.م",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: BaseConstant.cairoBold,
                          color: AppColors.natural300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Divider(height: 20),

            /// Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الإجمالي",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontFamily: BaseConstant.cairoBold,
                  ),
                ),
                Text(
                  "${order.totalPrice} ج.م",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontFamily: BaseConstant.cairoBold,
                    color: AppColors.primary400,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "تاريخ:  ${(order.createdAt ?? '').split('T').first}",
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
