import 'package:easy_life/Core/Extentions/padding_ext.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../Domain/Entity/service_deatils_entity.dart' hide Image;
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
          itemCount: serviceBranches.length,
          separatorBuilder: (context, index) =>
              const Divider(color: AppColors.natural400),
          itemBuilder: (context, index) {
            var service = serviceBranches[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    service.image ?? '',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return SvgPicture.asset(
                        AssetsStrings.noImages,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.black700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Html(
                        data: service.description ?? '',
                        style: {
                          "body": Style(
                            color: AppColors.natural400, // make text black
                            maxLines: 2, // limit lines
                            textOverflow: TextOverflow.ellipsis, // add "..."
                            fontSize: FontSize(14), // optional
                          ),
                          "p": Style(
                            margin:
                                Margins.zero, // remove default padding/margins
                            padding: HtmlPaddings.zero,
                            color: AppColors.natural400,
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        },
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            service.discount != '0'
                                ? TextSpan(
                                    text: service.discount ?? '0',
                                    style: TextStyle(color: Colors.black),
                                  )
                                : TextSpan(
                                    text: service.price ?? '0',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.primary400,
                                    ),
                                  ),
                            TextSpan(
                              text: ' جنيه',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.natural300,
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
                    // Check if service has options
                    if (service.serviceBranchOptions != null &&
                        service.serviceBranchOptions!.isNotEmpty) {
                      // Show bottom sheet with options
                      showModalBottomSheet(
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
                    } else {
                      // No options, add directly to cart
                      serviceCubit.addToCart(
                        type: 'service',
                        id: service.id!,
                        branchID: branchID,
                      );
                    }
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
