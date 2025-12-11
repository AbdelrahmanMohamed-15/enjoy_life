import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Services/setting_services.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

import '../Constant/assets_strings.dart';
import '../Constant/base_constant.dart';
import '../Handler/auth_handler.dart';
import '../Helper/user_validation_helper.dart';

class GeneralServiceCard extends StatefulWidget {
  final String logo;
  final String title;
  final bool isFavourite;
  final String rate;
  final String serviceName;
  final String description;
  final String address;
  final Function() addFavouriteTap;
  final Function() removeFavouriteTap;
  const GeneralServiceCard({
    super.key,
    required this.logo,
    required this.title,
    required this.isFavourite,
    required this.rate,
    required this.serviceName,
    required this.description,
    required this.address,
    required this.addFavouriteTap,
    required this.removeFavouriteTap,
  });

  @override
  State<GeneralServiceCard> createState() => _GeneralServiceCardState();
}

class _GeneralServiceCardState extends State<GeneralServiceCard> {
  bool isServiceFavourite = false;

  @override
  void initState() {
    initialFavourite();
    super.initState();
  }

  initialFavourite() {
    if (mounted) {
      setState(() {
        isServiceFavourite = widget.isFavourite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Userdata? userData = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getUserData();
    return Container(
      height: 240,
      width: 185,
      decoration: BoxDecoration(
        color: AppColors.natural100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: SettingServices.mainShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: 185,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    widget.logo,
                    height: 120,
                    width: 185,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return SvgPicture.asset(
                        AssetsStrings.noImage,
                        fit: BoxFit.fitHeight,
                      );
                    },
                  ),
                ),
                if (userData != null)
                  if (userData.clientType == 0)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.natural100,
                          shape: BoxShape.circle,
                        ),
                        child: LikeButton(
                          size: 25, // match your icon size
                          animationDuration: const Duration(milliseconds: 300),
                          isLiked: !isServiceFavourite,
                          likeCountPadding: const EdgeInsets.all(0),
                          circleColor: const CircleColor(
                            start: AppColors.iconPrimary,
                            end: AppColors.iconPrimary,
                          ),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: AppColors.iconPrimary,
                            dotSecondaryColor: AppColors.iconPrimary,
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              isServiceFavourite
                                  ? Icons.favorite_outlined
                                  : Icons.favorite_outline,
                              color: isServiceFavourite
                                  ? AppColors.iconPrimary
                                  : Colors.black,
                              size: 24, // slightly smaller to fit nicely
                            );
                          },
                          onTap: (isLike) async {
                            if (UserValidationHelper.checkUserValidation() ==
                                true) {
                              if (!isLike) {
                                widget.removeFavouriteTap();
                              } else {
                                widget.addFavouriteTap();
                              }
                              setState(() {
                                isServiceFavourite = !isServiceFavourite;
                              });
                              return !isLike;
                            } else {
                              UserValidationHelper.showUserValidation();
                              return false;
                            }
                          },
                        ),
                      ),
                    ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
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
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: AppColors.natural400,
                  ),
                ),
                const SizedBox(height: 5),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: RatingBar.builder(
                          initialRating: double.parse(widget.rate),
                          minRating: 0,
                          itemSize: 15,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                          unratedColor: AppColors.natural200,
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.amberAccent),
                          onRatingUpdate: (rating) {},
                        ),
                      ),
                      TextSpan(text: '   '),
                      TextSpan(
                        text: "(${widget.rate})",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.location_on_outlined,
                          color: AppColors.primary500,
                          size: 15,
                        ),
                      ),
                      TextSpan(
                        text: ' ${widget.address}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: BaseConstant.cairoBold,
                          color: AppColors.natural400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
