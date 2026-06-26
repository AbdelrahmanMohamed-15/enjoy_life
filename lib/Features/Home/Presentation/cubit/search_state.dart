part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchTyping extends SearchState {
  final String query;
  const SearchTyping({required this.query});

  @override
  List<Object?> get props => [query];
}

class SearchLoading extends SearchState {
  final String query;
  const SearchLoading({required this.query});

  @override
  List<Object?> get props => [query];
}

class SearchLoaded extends SearchState {
  final List<SearchData> results;
  final String query;
  const SearchLoaded({required this.results, required this.query});

  @override
  List<Object?> get props => [results, query];
}

class SearchEmpty extends SearchState {
  final String query;
  const SearchEmpty({required this.query});

  @override
  List<Object?> get props => [query];
}

class SearchError extends SearchState {
  final String message;
  final String query;
  const SearchError({required this.message, required this.query});

  @override
  List<Object?> get props => [message, query];
}

