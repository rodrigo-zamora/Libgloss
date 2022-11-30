part of 'used_search_bloc.dart';

@immutable
abstract class UsedSearchState {
  const UsedSearchState();

  List<dynamic> get props => [];
}

class UsedSearchInitial extends UsedSearchState {}

class UsedSearchLoading extends UsedSearchState {}

class UsedSearchLoaded extends UsedSearchState {
  final List<Map<String, dynamic>> usedBooks;

  const UsedSearchLoaded({required this.usedBooks});

  @override
  List<dynamic> get props => [usedBooks];

  @override
  String toString() => 'UsedSearchLoaded { usedBooks: $usedBooks }';
}

class UsedSearchError extends UsedSearchState {
  final String message;

  const UsedSearchError({required this.message});

  @override
  List<dynamic> get props => [message];

  @override
  String toString() => 'UsedSearchError { message: $message }';
}
