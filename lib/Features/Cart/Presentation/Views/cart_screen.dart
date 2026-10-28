import 'package:easy_life/Core/Widget/state_message_widget.dart';
import 'package:easy_life/Core/Constant/assets_strings.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Widget/main_app_button.dart';
import 'package:easy_life/Features/Cart/Presentation/Widget/quantity_widget.dart';
import 'package:easy_life/Features/Cart/Presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Helper/user_validation_helper.dart';
import '../../../../Core/Themes/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) => DependencyInjectionHelper().sl<CartCubit>()
        ..getCart()
        ..storeSession(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          var cartCubit = CartCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys.cartTitle.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                  color: AppColors.primary500,
                ),
              ),
              centerTitle: true,
              elevation: 2,
            ),
            body:
                cartCubit.cartRequestState == RequestState.error &&
                    cartCubit.cartEntity == null
                ? StateMessageWidget.error(onRetry: () => cartCubit.getCart())
                : cartCubit.cartEntity == null
                ? Center(child: CircularProgressIndicator())
                : cartCubit.cartRequestState == RequestState.empty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetsStrings.empty),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          LocaleKeys.cartEmpty.tr(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 17,
                            color: AppColors.black700,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          itemCount: cartCubit.cartEntity!.data!.items!.length,
                          itemBuilder: (context, index) {
                            var cart =
                                cartCubit.cartEntity!.data!.items![index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                child:
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child:
                                              cart.options!.itemType ==
                                                  'restaurant'
                                              ? Image.asset(
                                                  AssetsStrings.table,
                                                  height: 100,
                                                  width: 100,
                                                )
                                              : cart.options!.itemType ==
                                                    'hotel'
                                              ? Image.asset(
                                                  AssetsStrings.room,
                                                  height: 100,
                                                  width: 100,
                                                )
                                              : cart.options!.itemType == 'trip'
                                              ? Image.asset(
                                                  AssetsStrings.trip,
                                                  height: 100,
                                                  width: 100,
                                                )
                                              : Image.network(
                                                  cart.options?.image ?? '',
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) {
                                                        return SvgPicture.asset(
                                                          AssetsStrings
                                                              .noImages,
                                                          height: 100,
                                                          width: 100,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cart.name ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      color: AppColors.black700,
                                                    ),
                                              ),
                                              const SizedBox(height: 4),
                                              Html(
                                                data:
                                                    cart.options?.description ??
                                                    '',
                                                style: {
                                                  "body": Style(
                                                    color: AppColors
                                                        .natural400, // make text black
                                                    maxLines: 2, // limit lines
                                                    textOverflow: TextOverflow
                                                        .ellipsis, // add "..."
                                                    fontSize: FontSize(
                                                      14,
                                                    ), // optional
                                                  ),
                                                  "p": Style(
                                                    margin: Margins
                                                        .zero, // remove default padding/margins
                                                    padding: HtmlPaddings.zero,
                                                    color: AppColors.natural400,
                                                    maxLines: 2,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                },
                                              ),

                                              const SizedBox(height: 4),
                                              if (cart.options!.itemType ==
                                                  'service')
                                                QuantityWidget(
                                                  quantity: cart.qty ?? 0,
                                                  onAdd: () {
                                                    cartCubit
                                                        .updateItemQuantity(
                                                          rowID: cart.rowId!,
                                                          quantity: cart.qty
                                                              .toString(),
                                                          type: 'add',
                                                        );
                                                  },
                                                  onRemove: () {
                                                    cartCubit
                                                        .updateItemQuantity(
                                                          rowID: cart.rowId!,
                                                          quantity: cart.qty
                                                              .toString(),
                                                          type: 'remove',
                                                        );
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        GestureDetector(
                                          onTap: () {
                                            cartCubit.removeItemCart(
                                              rowID: cart.rowId!,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 1,
                                                color: AppColors.darkRed,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.delete_outlined,
                                              size: 20,
                                              color: AppColors.darkRed,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).setVerticalPadding(
                                      context,
                                      8,
                                      enableMediaQuery: false,
                                    ),
                              ),
                            ).setVerticalPadding(
                              context,
                              4,
                              enableMediaQuery: false,
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: LocaleKeys.cartTotal.tr(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: BaseConstant.cairoBold,
                                      color: AppColors.primary400,
                                    ),
                                  ),
                                  TextSpan(text: '  '),
                                  TextSpan(
                                    text:
                                        '${cartCubit.cartEntity!.data!.total}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: BaseConstant.cairoBold,
                                      color: AppColors.black700,
                                    ),
                                  ),
                                  TextSpan(text: '  '),
                                  TextSpan(
                                    text: LocaleKeys.commonCurrencyEgp.tr(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: BaseConstant.cairoBold,
                                      color: AppColors.primary400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(color: AppColors.natural400),
                            const SizedBox(height: 10),
                            MainAppButton(
                              bgColor: AppColors.primary400,
                              child: Text(
                                LocaleKeys.cartCheckout.tr(),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                if (UserValidationHelper.checkUserValidation() ==
                                    true) {
                                  cartCubit.createOrder();
                                } else {
                                  UserValidationHelper.showUserValidation();
                                }
                              },
                            ).setCenter(),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
