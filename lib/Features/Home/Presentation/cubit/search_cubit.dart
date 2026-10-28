import 'package:easy_life/Core/Helper/safe_emit_mixin.dart';
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/Entity/search_entity.dart';
import '../../Domain/Usecases/search_usecases.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> with SafeEmitMixin<SearchState> {
  SearchCubit({required this.searchUsecases}) : super(SearchInitial());

  final SearchUsecases searchUsecases;

  Timer? _debounce;

  void onQueryChanged(String query) {
    emit(SearchTyping(query: query));

    _debounce?.cancel();
    if (query.trim().length < 2) {
      _latestQuery = '';
      emit(SearchInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () {
      _performSearch(query.trim());
    });
  }

  /// The query the UI is showing; replies for older queries are dropped
  String _latestQuery = '';

  Future<void> _performSearch(String query) async {
    _latestQuery = query;
    emit(SearchLoading(query: query));
    final res = await searchUsecases.call(query: query);
    // A slower reply for an earlier query must not replace newer results
    if (query != _latestQuery) return;
    res.fold(
      (failure) => emit(SearchError(message: failure.message, query: query)),
      (searchEntity) {
        final results = searchEntity.data ?? [];
        if (results.isEmpty) {
          emit(SearchEmpty(query: query));
        } else {
          emit(SearchLoaded(results: results, query: query));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
