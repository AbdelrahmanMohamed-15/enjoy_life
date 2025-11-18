import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AdvancedShimmer extends StatelessWidget {
  final double width;
  final double height;
  final ShimmerDirection direction;
  final Duration period;
  final Color baseColor;
  final Color highlightColor;
  final double borderRadius;
  final BoxShape shape;
  final Widget? customChild;
  final ShimmerType type;
  final int lines;
  final bool hasAvatar;
  final bool hasIcons;

  const AdvancedShimmer({
    Key? key,
    required this.width,
    required this.height,
    this.direction = ShimmerDirection.ltr,
    this.period = const Duration(milliseconds: 1500),
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.borderRadius = 8.0,
    this.shape = BoxShape.rectangle,
    this.customChild,
    this.type = ShimmerType.normal,
    this.lines = 3,
    this.hasAvatar = false,
    this.hasIcons = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer(
        direction: direction,
        period: period,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [baseColor, baseColor, highlightColor, baseColor, baseColor],
          stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
        ),
        child: customChild ?? _buildShimmerContent(),
      ),
    );
  }

  Widget _buildShimmerContent() {
    switch (type) {
      case ShimmerType.card:
        return _buildCardShimmer();
      case ShimmerType.listTile:
        return _buildListTileShimmer();
      case ShimmerType.detailed:
        return _buildDetailedShimmer();
      default:
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: shape == BoxShape.rectangle
                ? BorderRadius.circular(borderRadius)
                : null,
            shape: shape,
          ),
        );
    }
  }

  Widget _buildCardShimmer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title line
          Container(
            width: width * 0.6,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 12),

          // Content lines
          for (int i = 0; i < lines; i++) ...[
            Container(
              width: i == lines - 1 ? width * 0.4 : double.infinity,
              height: 12,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],

          // Spacer and button
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 80,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListTileShimmer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasAvatar)
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Container(
                  width: width * 0.4,
                  height: 16,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                // Subtitle
                Container(
                  width: width * 0.7,
                  height: 14,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                // Additional info
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 40,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (hasIcons)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailedShimmer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with avatar and title
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 80,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (hasIcons)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Image placeholder
          Container(
            width: double.infinity,
            height: height * 0.4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          const SizedBox(height: 16),

          // Content lines
          for (int i = 0; i < lines; i++) ...[
            Container(
              width: i == lines - 1 ? width * 0.6 : double.infinity,
              height: 12,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (int i = 0; i < 3; i++)
                Container(
                  width: 60,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Footer with buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 80,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              Container(
                width: 80,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              Container(
                width: 80,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum ShimmerType { normal, card, listTile, detailed }

// Example usage
class ShimmerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Advanced Shimmer Examples')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Card Shimmer', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 10),
            AdvancedShimmer(
              width: double.infinity,
              height: 180,
              type: ShimmerType.card,
              lines: 3,
            ),

            const SizedBox(height: 20),

            Text(
              'ListTile Shimmer',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            AdvancedShimmer(
              width: double.infinity,
              height: 90,
              type: ShimmerType.listTile,
              hasAvatar: true,
              hasIcons: true,
            ),

            const SizedBox(height: 20),

            Text(
              'Detailed Shimmer',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            AdvancedShimmer(
              width: double.infinity,
              height: 400,
              type: ShimmerType.detailed,
              lines: 4,
              hasIcons: true,
            ),
          ],
        ),
      ),
    );
  }
}
