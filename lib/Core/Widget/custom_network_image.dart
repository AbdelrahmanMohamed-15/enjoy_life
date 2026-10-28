import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constant/assets_strings.dart';
import '../Themes/app_colors.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  // Shown when the url is empty or the image fails to load (e.g. 404)
  final Widget? errorWidget;
  const CustomNetworkImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final double imageWidth = width ?? double.infinity;
    final double imageHeight = height ?? 80;

    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return _placeholder(imageWidth, imageHeight);
    }

    return Image.network(
      imageUrl!,
      width: imageWidth,
      height: imageHeight,
      fit: fit ?? BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: imageWidth,
          height: imageHeight,
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary400,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Image failed to load: $imageUrl');
        return _placeholder(imageWidth, imageHeight);
      },
    );
  }

  Widget _placeholder(double width, double height) {
    return errorWidget ??
        Container(
          width: width,
          height: height,
          color: Colors.white,
          child: SvgPicture.asset(AssetsStrings.noImages, fit: BoxFit.cover),
        );
  }
}
