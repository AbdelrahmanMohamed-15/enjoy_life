import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Core/Constant/assets_strings.dart';
import '../../Domain/Entity/slider_entity.dart';

class CarouselBanner extends StatelessWidget {
  final SliderEntity sliderEntity;
  final double height;
  final bool autoPlay;

  const CarouselBanner({
    super.key,
    required this.sliderEntity,
    this.height = 200.0,
    this.autoPlay = true,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: sliderEntity.data!.map((slider) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            slider.image ?? '',
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.white,
                width: double.infinity,
                height: height,
                child: SvgPicture.asset(
                  AssetsStrings.errorImage,
                  fit: BoxFit.fitHeight,
                ),
              );
            },
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: height,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
