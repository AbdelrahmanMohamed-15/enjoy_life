import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';

import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Routes/app_routes.dart';
import '../../../../Core/Services/setting_services.dart';
import '../../../../Core/Themes/app_colors.dart';

class MyFavouriteScreen extends StatelessWidget {
  const MyFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) =>
          DependencyInjectionHelper().sl<HomeCubit>()..getMyFavourite(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys.homeFavoritesTitle.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                  color: AppColors.primary500,
                ),
              ),
              centerTitle: true,
              elevation: 2,
            ),
            body: homeCubit.myFavouriteEntity == null
                ? const Center(child: CircularProgressIndicator())
                : homeCubit.myFavouriteRequestState == RequestState.empty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetsStrings.empty),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          LocaleKeys.homeFavoritesEmpty.tr(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 17,
                            color: AppColors.black700,
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    itemCount: homeCubit.myFavouriteEntity!.data!.length,
                    itemBuilder: (context, index) {
                      var favourite = homeCubit.myFavouriteEntity!.data![index];
                      return GestureDetector(
                        onTap: () {
                          debugPrint('serviceID ${favourite.id}');
                          debugPrint('serviceID ${favourite.serviceName}');
                          AppNavigation.pushNamed(
                            AppRoutes.resturantDetails,
                            arguments: {
                              "serviceID": favourite.itemID,
                              "type": favourite.serviceName,
                            },
                          );
                        },
                        child: Container(
                          height: 130,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.natural100,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: SettingServices.mainShadow,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 130,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.only(
                                    bottomRight: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    favourite.logo ?? '',
                                    height: 120,
                                    width: 185,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        favourite.name ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontFamily:
                                                  BaseConstant.cairoBold,
                                              color: AppColors.black700,
                                            ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        favourite.description ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
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
                                                initialRating: double.parse(
                                                  favourite.rating ?? '0',
                                                ),
                                                minRating: 0,
                                                itemSize: 15,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                ignoreGestures: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 0.5,
                                                    ),
                                                unratedColor:
                                                    AppColors.natural200,
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amberAccent,
                                                    ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                            ),
                                            TextSpan(text: '   '),
                                            TextSpan(
                                              text: "(${favourite.rating})",
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
                                              text: ' ${favourite.address}',
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                    fontFamily:
                                                        BaseConstant.cairoBold,
                                                    color: AppColors.natural400,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: AppColors.natural200,
                                        shape: BoxShape.circle,
                                      ),
                                      child: LikeButton(
                                        size: 25, // match your icon size
                                        animationDuration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        isLiked: true,
                                        likeCountPadding: const EdgeInsets.all(
                                          0,
                                        ),
                                        circleColor: const CircleColor(
                                          start: AppColors.iconPrimary,
                                          end: AppColors.iconPrimary,
                                        ),
                                        bubblesColor: const BubblesColor(
                                          dotPrimaryColor:
                                              AppColors.iconPrimary,
                                          dotSecondaryColor:
                                              AppColors.iconPrimary,
                                        ),
                                        likeBuilder: (bool isLiked) {
                                          return Icon(
                                            Icons.favorite_outlined,
                                            color: AppColors.iconPrimary,
                                            size:
                                                24, // slightly smaller to fit nicely
                                          );
                                        },
                                        onTap: (isLike) async {
                                          debugPrint(
                                            'Service Name : ${favourite.serviceName}',
                                          );
                                          await homeCubit.removeFavourite(
                                            id: favourite.itemID!,
                                            type: favourite.serviceName!,
                                          );
                                          await homeCubit.getMyFavourite();
                                          await homeCubit.getResturant();
                                          await homeCubit.getHotels();
                                          await homeCubit.getTrips();
                                          return !isLike;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
