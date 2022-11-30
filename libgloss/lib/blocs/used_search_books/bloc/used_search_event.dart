part of 'used_search_bloc.dart';

@immutable
abstract class UsedSearchEvent {
  const UsedSearchEvent();

  List<dynamic> get props => [];
}

class SearchUsedBooksEvent extends UsedSearchEvent {
  final String query;

  const SearchUsedBooksEvent(this.query);

  @override
  List<dynamic> get props => [query];

  @override
  String toString() => 'SearchUsedBooksEvent { query: $query }';
}
