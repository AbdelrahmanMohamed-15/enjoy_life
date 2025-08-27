import 'package:flutter/widgets.dart';

// myWidget is centered by calling the setCenter extension method.
// the new widget with myWidget positioned in the center
extension CenterToWidget on Widget {
  Widget setCenter() {
    return Center(
      child: this,
    );
  }
}