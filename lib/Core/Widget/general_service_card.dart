import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constant/assets_strings.dart';
import '../Constant/base_constant.dart';
import '../Helper/service_kind.dart';
import '../Helper/user_validation_helper.dart';
import 'booking_type_icon.dart';

/// Restaurant / hotel / trip card used in the home rails and grids.
class GeneralServiceCard extends StatefulWidget {
  final String logo;
  final String title;
  final bool isFavourite;
  final String rate;
  final ServiceKind? kind;
  final String description;
  final String address;
  final VoidCallback? onTap;

  /// Called with the new value; return false to undo the toggle. Hidden when
  /// null (e.g. for vendors).
  final Future<bool> Function(bool favourite)? onFavouriteChanged;
  final double width;
  const GeneralServiceCard({
    super.key,
    required this.logo,
    required this.title,
    required this.isFavourite,
    required this.rate,
    required this.description,
    required this.address,
    this.kind,
    this.onTap,
    this.onFavouriteChanged,
    this.width = 200,
  });

  @override
  State<GeneralServiceCard> createState() => _GeneralServiceCardState();
}

class _GeneralServiceCardState extends State<GeneralServiceCard> {
  late bool _favourite = widget.isFavourite;
  bool _busy = false;

  @override
  void didUpdateWidget(covariant GeneralServiceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Fresh data from the server wins over the local toggle
    if (oldWidget.isFavourite != widget.isFavourite) {
      _favourite = widget.isFavourite;
    }
  }

  Future<void> _toggleFavourite() async {
    if (_busy) return;
    if (UserValidationHelper.checkUserValidation() != true) {
      UserValidationHelper.showUserValidation();
      return;
    }
    final next = !_favourite;
    setState(() {
      _favourite = next;
      _busy = true;
    });
    final ok = await widget.onFavouriteChanged!(next);
    if (!mounted) return;
    setState(() {
      if (!ok) _favourite = !next;
      _busy = false;
    });
  }

  String get _rating {
    final value = double.tryParse(widget.rate) ?? 0;
    return value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      width: widget.width,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: InkWell(
          onTap: widget.onTap,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.natural200.withValues(alpha: 0.7),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.logo,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            SvgPicture.asset(
                              AssetsStrings.noImages,
                              fit: BoxFit.cover,
                            ),
                      ),
                      // Rating badge
                      PositionedDirectional(
                        top: 10,
                        start: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFFC83D),
                                size: 15,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                _rating,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: BaseConstant.cairoBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (widget.onFavouriteChanged != null)
                        PositionedDirectional(
                          top: 8,
                          end: 8,
                          child: Material(
                            color: Colors.white,
                            shape: const CircleBorder(),
                            elevation: 2,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: _toggleFavourite,
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  transitionBuilder: (child, animation) =>
                                      ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                  child: Icon(
                                    _favourite
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    key: ValueKey(_favourite),
                                    color: _favourite
                                        ? AppColors.errorColor
                                        : AppColors.natural600,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (widget.kind != null)
                        PositionedDirectional(
                          bottom: 8,
                          start: 8,
                          child: BookingTypeIcon(
                            itemType: widget.kind!.itemType,
                            size: 30,
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: BaseConstant.cairoBold,
                          color: AppColors.black700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.natural500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: AppColors.primary500,
                            size: 15,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              widget.address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.natural600,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
