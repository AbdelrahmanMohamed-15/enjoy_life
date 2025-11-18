import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const CustomNetworkImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl ?? '',
      width: width ?? double.infinity,
      height: height ?? 80,
      fit: fit ?? BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.network(
          'https://blocks.astratic.com/img/general-img-landscape.png',
          width: double.infinity,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
