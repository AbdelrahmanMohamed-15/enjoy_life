import 'package:easy_life/Core/Constant/assets_strings.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Home/Domain/Entity/search_entity.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/search_usecases.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        searchUsecases: DependencyInjectionHelper().sl<SearchUsecases>(),
      ),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final searchCubit = context.read<SearchCubit>();
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primary500,
                  size: 20,
                ),
                onPressed: () => AppNavigation.pop(),
              ),
              titleSpacing: 0,
              title: Padding(
                padding: const EdgeInsetsDirectional.only(end: 16),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.natural200),
                  ),
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    cursorColor: AppColors.primary500,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.homeSearchHint.tr(),
                      hintStyle: const TextStyle(
                        color: AppColors.natural400,
                        fontSize: 14,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.primary500,
                      ),
                      suffixIcon: _controller.text.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(
                                Icons.close_rounded,
                                color: AppColors.natural500,
                              ),
                              onPressed: () {
                                _controller.clear();
                                searchCubit.onQueryChanged('');
                                setState(() {});
                              },
                            ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {});
                      searchCubit.onQueryChanged(value);
                    },
                  ),
                ),
              ),
            ),
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(SearchState state) {
    if (state is SearchInitial ||
        state is SearchTyping && state.query.isEmpty) {
      return _buildHint();
    }

    if (state is SearchLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is SearchError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: AppColors.darkRed,
                size: 40,
              ),
              const SizedBox(height: 12),
              Text(
                state.message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.darkRed),
              ),
            ],
          ),
        ),
      );
    }

    if (state is SearchEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.search_off,
                color: AppColors.natural400,
                size: 40,
              ),
              const SizedBox(height: 12),
              Text(
                LocaleKeys.homeSearchNoResults.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.natural400),
              ),
            ],
          ),
        ),
      );
    }

    if (state is SearchLoaded) {
      return _buildResults(state.results);
    }

    return const SizedBox();
  }

  Widget _buildHint() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search, color: AppColors.natural400, size: 40),
            const SizedBox(height: 12),
            Text(
              LocaleKeys.homeSearchEmptyHint.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.natural400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(List<SearchData> results) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return GestureDetector(
          onTap: () {
            AppNavigation.pushNamed(
              AppRoutes.resturantDetails,
              arguments: {'serviceID': item.id ?? 0, 'type': item.type ?? ''},
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  offset: const Offset(0, 6),
                  blurRadius: 18,
                  spreadRadius: 0,
                ),
              ],
              border: Border.all(color: AppColors.natural200, width: 0.7),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _buildThumbnail(item.logo),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.black700,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary100,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Text(
                                item.type ?? '',
                                style: const TextStyle(
                                  color: AppColors.primary500,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        if ((item.address ?? '').isNotEmpty)
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: AppColors.natural400,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  item.address ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.natural400,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if ((item.address ?? '').isNotEmpty)
                          const SizedBox(height: 6),
                        Row(
                          children: [
                            if ((item.phone ?? '').isNotEmpty) ...[
                              const Icon(
                                Icons.phone_in_talk,
                                size: 13,
                                color: AppColors.natural400,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.phone ?? '',
                                style: const TextStyle(
                                  color: AppColors.natural400,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: AppColors.natural300,
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
        );
      },
    );
  }

  Widget _buildThumbnail(String? logo) {
    if (logo == null || logo.isEmpty) {
      return CircleAvatar(
        backgroundColor: AppColors.primary100,
        child: const Icon(
          Icons.storefront,
          color: AppColors.primary500,
          size: 20,
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        logo,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return SvgPicture.asset(
            AssetsStrings.noImages,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
