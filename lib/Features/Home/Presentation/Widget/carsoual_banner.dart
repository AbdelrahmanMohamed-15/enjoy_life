import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../Domain/Entity/slider_entity.dart';

class CarouselBanner extends StatefulWidget {
  final SliderEntity sliderEntity;
  final double height;
  final bool autoPlay;

  const CarouselBanner({
    super.key,
    required this.sliderEntity,
    this.height = 170.0,
    this.autoPlay = true,
  });

  @override
  State<CarouselBanner> createState() => _CarouselBannerState();
}

class _CarouselBannerState extends State<CarouselBanner> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final slides = widget.sliderEntity.data ?? [];
    return Column(
      children: [
        CarouselSlider(
          items: slides.map((slider) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  slider.image ?? '',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.white,
                    child: SvgPicture.asset(
                      AssetsStrings.noImages,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: widget.height,
            // A single slide has nothing to rotate to
            autoPlay: widget.autoPlay && slides.length > 1,
            enableInfiniteScroll: slides.length > 1,
            enlargeCenterPage: true,
            viewportFraction: 0.88,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            onPageChanged: (index, _) => setState(() => _current = index),
          ),
        ),
        if (slides.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < slides.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _current == i ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _current == i
                          ? AppColors.primary500
                          : AppColors.natural300,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
