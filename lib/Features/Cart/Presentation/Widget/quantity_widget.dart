import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:flutter/material.dart';

class QuantityWidget extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  const QuantityWidget({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.3,
      child: Row(
        children: [
          GestureDetector(
            onTap: onAdd,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.primary400,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                quantity.toString(),
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: AppColors.black700,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: quantity == 1 ? () {} : onRemove,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: quantity == 1
                    ? AppColors.natural400
                    : AppColors.primary400,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(Icons.remove, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
