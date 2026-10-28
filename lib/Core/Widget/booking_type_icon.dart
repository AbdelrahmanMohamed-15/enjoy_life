import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:flutter/material.dart';

/// Gradient tile with a rounded Material icon for a bookable item type
/// ('restaurant', 'hotel', 'trip'), used instead of flat PNG illustrations.
class BookingTypeIcon extends StatelessWidget {
  final String itemType;
  final double size;
  const BookingTypeIcon({super.key, required this.itemType, this.size = 70});

  static bool supports(String? itemType) =>
      itemType == 'restaurant' || itemType == 'hotel' || itemType == 'trip';

  IconData get _icon => switch (itemType) {
    'restaurant' => Icons.table_restaurant_rounded,
    'hotel' => Icons.king_bed_rounded,
    'trip' => Icons.airport_shuttle_rounded,
    _ => Icons.room_service_rounded,
  };

  List<Color> get _colors => switch (itemType) {
    'hotel' => const [Color(0xFF5B8DEF), Color(0xFF3A5FCD)],
    'trip' => const [Color(0xFF2EC4A6), Color(0xFF16967D)],
    _ => const [AppColors.primary300, AppColors.primary600],
  };

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(size * 0.28);
    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _colors,
        ),
        boxShadow: [
          BoxShadow(
            color: _colors.last.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // soft highlight circle for depth
          Positioned(
            top: -size * 0.25,
            right: -size * 0.25,
            child: Container(
              height: size * 0.7,
              width: size * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
          ),
          Icon(_icon, color: Colors.white, size: size * 0.5),
        ],
      ),
    );
  }
}
