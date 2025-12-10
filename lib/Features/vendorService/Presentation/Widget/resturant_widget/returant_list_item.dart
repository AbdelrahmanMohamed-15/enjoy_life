import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/vendor_service_cubit.dart';
import 'returant_item_widget.dart';

class ReturantListItem extends StatelessWidget {
  const ReturantListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      buildWhen: (previous, current) {
        // Rebuild when TableUpdated state is emitted
        return current is TableUpdated || previous is TableUpdated;
      },
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        var list = vendorServiceCubit.tableList;
        return ListView.builder(
          key: ValueKey(list.length), // Force rebuild when list length changes
          itemCount: list.length,
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ReturantItemWidget(
              index: index,
            ).setHorizontalAndVerticalPadding(
              context,
              15,
              6,
              enableMediaQuery: false,
            );
          },
        );
      },
    );
  }
}
