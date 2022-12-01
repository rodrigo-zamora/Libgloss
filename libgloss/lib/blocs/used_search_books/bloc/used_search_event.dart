part of 'used_search_bloc.dart';

@immutable
abstract class UsedSearchEvent {
  const UsedSearchEvent();

  List<dynamic> get props => [];
}

class SearchUsedBooksEvent extends UsedSearchEvent {
  final String query;
  final Map<String, dynamic> filters;

  const SearchUsedBooksEvent({
    required String this.query,
    required Map<String, dynamic> this.filters,
  });

  @override
  List<dynamic> get props => [query];

  @override
  String toString() => 'SearchUsedBooksEvent { query: $query  }';
}
