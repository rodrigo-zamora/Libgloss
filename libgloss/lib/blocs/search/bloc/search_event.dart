part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();

  List<dynamic> get props => [];
}

class SearchBoookEvent extends SearchEvent {
  final String query;
  final Map<String, dynamic> filters;

  const SearchBoookEvent({
    required String this.query,
    required Map<String, dynamic> this.filters,
  });

  @override
  List<dynamic> get props => [
      query,
      filters,
    ];

  @override
  String toString() => 'SearchBoookEvent { query: $query, filters: $filters }';
}
