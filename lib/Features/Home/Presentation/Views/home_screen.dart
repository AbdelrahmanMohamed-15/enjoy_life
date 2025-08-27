import 'package:easy_life/Features/Home/Presentation/Widget/main_bar.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Enums/level_message_enums.dart';
import '../Widget/carsoual_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          body: Column(
            children: [
              MainBar(),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    if (homeCubit.slidersEntity != null) ...[
                      homeCubit.sliderRequestState == RequestState.empty
                          ? const SizedBox()
                          : CarouselBanner(
                              sliderEntity: homeCubit.slidersEntity!,
                            ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
