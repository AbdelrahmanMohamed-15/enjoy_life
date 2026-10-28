import 'package:flutter/material.dart';

import '../../../../Core/Enums/level_message_enums.dart';

/// A home section that hides itself when it is empty or failed to load
class HomeSection extends StatelessWidget {
  final RequestState requestState;
  final bool hasData;
  final Widget Function() builder;
  const HomeSection({
    super.key,
    required this.requestState,
    required this.hasData,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (requestState == RequestState.error ||
        requestState == RequestState.empty) {
      return const SizedBox();
    }
    if (!hasData) {
      return Container(
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: double.infinity,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return builder();
  }
}
