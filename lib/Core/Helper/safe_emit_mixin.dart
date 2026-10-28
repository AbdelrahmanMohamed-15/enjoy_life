import 'package:flutter_bloc/flutter_bloc.dart';

/// Ignores states emitted after the cubit is closed, e.g. when the user
/// leaves a screen before its request finishes.
mixin SafeEmitMixin<S> on Cubit<S> {
  @override
  void emit(S state) {
    if (isClosed) return;
    super.emit(state);
  }
}
