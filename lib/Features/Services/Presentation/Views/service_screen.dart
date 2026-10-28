import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Core/Widget/custom_network_image.dart';
import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import '../../Domain/Entity/service_deatils_entity.dart' hide Image;
import '../Widget/bookable_item_card.dart';
import '../Widget/service_branch_options_bottomsheet.dart';

class ServiceScreen extends StatelessWidget {
  final String title;
  final int branchID;
  final List<ServiceBranch> serviceBranches;
  final ServiceCubit serviceCubit;
  const ServiceScreen({
    super.key,
    required this.branchID,
    required this.serviceBranches,
    required this.title,
    required this.serviceCubit,
  });

  /// (price to pay, original price when discounted). The discount is an
  /// amount off the price, matching order totals (total = price - discount).
  (String, String?) _prices(ServiceBranch service) {
    final price = double.tryParse(service.price ?? '') ?? 0;
    final discount = double.tryParse(service.discount ?? '') ?? 0;
    String fmt(double v) =>
        v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(2);
    if (discount > 0 && discount < price) {
      return (fmt(price - discount), fmt(price));
    }
    return (fmt(price), null);
  }

  Future<bool> _add(BuildContext context, ServiceBranch service) async {
    final options = service.serviceBranchOptions ?? [];
    if (options.isEmpty) {
      return serviceCubit.addToCart(
        type: 'service',
        id: service.id!,
        branchID: branchID,
      );
    }
    // Let the user pick options; the sheet adds to the cart itself
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ServiceBranchOptionsBottomSheet(
        serviceBranch: service,
        branchID: branchID,
        serviceCubit: serviceCubit,
        serviceName: service.name ?? '',
      ),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppPageBar(title: title),
      body: serviceBranches.isEmpty
          ? StateMessageWidget.empty()
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: serviceBranches.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                var service = serviceBranches[index];
                final (price, oldPrice) = _prices(service);
                return BookableItemCard(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CustomNetworkImage(
                      imageUrl: service.image,
                      height: 76,
                      width: 76,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: service.name ?? '',
                  // Descriptions are HTML; strip tags for the one-line preview
                  subtitle: _plain(service.description),
                  price: price,
                  oldPrice: oldPrice,
                  onAdd: () => _add(context, service),
                );
              },
            ),
    );
  }

  static String _plain(String? html) => (html ?? '')
      .replaceAll(RegExp(r'<[^>]*>'), ' ')
      .replaceAll('&nbsp;', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
