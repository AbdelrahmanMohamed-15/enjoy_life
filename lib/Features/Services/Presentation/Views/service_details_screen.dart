import 'package:easy_life/Core/Routes/routes.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/main_app_button.dart';
import 'package:easy_life/Core/Widget/map_location_widget.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:easy_life/Features/Services/Domain/Entity/service_deatils_entity.dart'
    hide Image;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Enums/level_message_enums.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../Widget/select_slot_bottomsheet.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final int serviceID;
  final String type;
  final int? id;
  const ServiceDetailsScreen({
    super.key,
    required this.serviceID,
    required this.type,
    this.id,
  });

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  Branch? selectedBranch;
  String? selectedImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Userdata? userData = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getUserData();
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        var serviceCubit = ServiceCubit.get(context);
        if (serviceCubit.serviceDetails == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (serviceCubit.serviceRequestState == RequestState.empty) {
          return const Scaffold(
            body: Center(child: Text("حدث خطأ أثناء تحميل التفاصيل")),
          );
        }

        if (serviceCubit.serviceDetails != null) {
          final resturant = serviceCubit.serviceDetails!.data!;
          List<Branch> branches = [];
          if (resturant.serviceBranches != null) {
            for (var branch in resturant.serviceBranches!) {
              branches.add(branch.branch!);
            }
          }
          final uniqueBranches = branches.toSet().toList();
          // Filter services for the selected branch and remove duplicates by id
          List<ServiceBranch> uniqueBranchesById = {
            for (var sb in resturant.serviceBranches!.where(
              (s) => s.branch?.id == selectedBranch?.id,
            ))
              sb.id: sb,
          }.values.toList();

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                elevation: 2,
                title: Text(resturant.name ?? ""),
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    AppNavigation.pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primary400,
                  ),
                ),
                actions: const [
                  // Icon(Icons.favorite_border),
                  // SizedBox(width: 12),
                  Icon(Icons.share),
                  SizedBox(width: 12),
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Branch Dropdown
                    if (userData != null)
                      if (userData.clientType == 0) ...[
                        if (branches.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<Branch>(
                              isExpanded: true,
                              underline: const SizedBox(),
                              hint: const Text("اختر الفرع"),
                              value: selectedBranch,
                              items: uniqueBranches.toSet().map((branch) {
                                return DropdownMenuItem<Branch>(
                                  value: branch,
                                  child: Text(branch.name ?? branch.name ?? ""),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedBranch = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
                        ],
                      ],

                    // 🔹 Main Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        selectedImage ?? resturant.logo ?? "",
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return SvgPicture.asset(
                            AssetsStrings.noImages,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 🔹 Horizontal images
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: resturant.images?.length ?? 0,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final img = resturant.images![index];
                          return GestureDetector(
                            onTap: () {
                              debugPrint('change image');
                              setState(() {
                                selectedImage = img.url ?? "";
                              });
                              debugPrint('change image');
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                img.url ?? resturant.logo ?? "",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return SvgPicture.asset(
                                    AssetsStrings.noImages,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 25),
                    // 🔹 Description
                    Text(
                      resturant.description ?? "",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.natural400,
                        fontFamily: BaseConstant.cairoBold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Rating + Address
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: RatingBar.builder(
                              initialRating: resturant.avarageRating ?? 0,
                              minRating: 0,
                              itemSize: 18,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(
                                horizontal: 1.0,
                              ),
                              unratedColor: AppColors.natural200,
                              itemBuilder: (context, _) =>
                                  Icon(Icons.star, color: Colors.amberAccent),
                              onRatingUpdate: (rating) {},
                            ),
                          ),
                          TextSpan(text: '   '),
                          TextSpan(
                            text: "(${resturant.avarageRating ?? 0})",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.location_on_outlined, size: 15),
                          ),
                          TextSpan(text: '   '),
                          TextSpan(
                            text: resturant.address ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // 🔹 Map placeholder
                    MapLocationWidget(
                      latitude:
                          double.tryParse(resturant.latitude ?? '0.0') ?? 0.0,
                      longitude:
                          double.tryParse(resturant.longitude ?? '0.0') ?? 0.0,
                    ),
                    const SizedBox(height: 20),
                    if (resturant.rates!.isNotEmpty) ...[
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: resturant.rates!.length,
                        separatorBuilder: (_, __) =>
                            const Divider(color: AppColors.natural400),
                        itemBuilder: (context, index) {
                          var rates = resturant.rates![index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary400,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      rates.clientImage ?? '',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rates.clientName ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: AppColors.black700,
                                            fontFamily: BaseConstant.cairoBold,
                                          ),
                                    ),
                                    const SizedBox(height: 5),
                                    // 🔹 Rating + Address
                                    RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: RatingBar.builder(
                                              initialRating: double.parse(
                                                rates.rating ?? '0.0',
                                              ),
                                              minRating: 0,
                                              itemSize: 18,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              ignoreGestures: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                horizontal: 1.0,
                                              ),
                                              unratedColor:
                                                  AppColors.natural200,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amberAccent,
                                              ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                          ),
                                          TextSpan(text: '   '),
                                          TextSpan(
                                            text: "(${rates.rating ?? 0})",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      rates.comment ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: AppColors.natural400,
                                            fontFamily: BaseConstant.cairoBold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    if (userData != null)
                      if (userData.clientType == 0) ...[
                        // 🔹 Show only if serviceBranches not empty
                        if (selectedBranch != null) ...[
                          Expanded(
                            child: MainAppButton(
                              bgColor: AppColors.primary400,
                              child: Text(
                                "الخدمات",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.natural100,
                                  fontFamily: BaseConstant.cairoBold,
                                ),
                              ),
                              onTap: () {
                                AppNavigation.pushNamed(
                                  AppRoutes.serviceScreen,
                                  arguments: {
                                    'serviceBranches': uniqueBranchesById,
                                    'title': resturant.name ?? '',
                                    'branchID': selectedBranch?.id ?? 0,
                                    'serviceCubit': serviceCubit,
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],

                        Expanded(
                          child: MainAppButton(
                            bgColor: AppColors.primary400,
                            child: Text(
                              "احجز الان",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: AppColors.natural100,
                                fontFamily: BaseConstant.cairoBold,
                              ),
                            ),
                            onTap: () {
                              if (widget.type.toLowerCase() == 'resturant' ||
                                  widget.type.toLowerCase() == 'مطعم' ||
                                  widget.type.toLowerCase() == 'hotel' ||
                                  widget.type.toLowerCase() == 'فندق') {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (_) {
                                    return BookingTimeBottomSheet(
                                      serviceCubit: serviceCubit,
                                      type: widget.type,
                                      title: resturant.name ?? '',
                                      serviceID: resturant.id ?? 0,
                                    );
                                  },
                                );
                              } else {
                                serviceCubit.getAvaliableTrips(
                                  tripID: resturant.id ?? 0,
                                  title: resturant.name ?? '',
                                  serviceCubit: serviceCubit,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                  ],
                ),
              ),
            ),
          );
        }

        return const Scaffold();
      },
    );
  }
}
