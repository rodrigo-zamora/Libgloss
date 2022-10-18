part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  const SearchState();

  List<dynamic> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<dynamic> books;

  const SearchLoaded({required this.books});

  @override
  List<dynamic> get props => [books];

  @override
  String toString() => 'SearchLoaded { books: $books }';
}

class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<dynamic> get props => [message];

  @override
  String toString() => 'SearchError { message: $message }';
}

class BookLoading extends SearchState {}

class BookLoaded extends SearchState {
  final Map<String, dynamic> bookDetails;

  const BookLoaded({required this.bookDetails});

  @override
  List<dynamic> get props => [bookDetails];

  @override
  String toString() => 'BookLoaded { bookDetails: $bookDetails }';
}
