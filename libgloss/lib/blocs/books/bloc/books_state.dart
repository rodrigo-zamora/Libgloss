part of 'books_bloc.dart';

@immutable
abstract class BooksState {
  const BooksState();

  List<dynamic> get props => [];
}

class BooksInitial extends BooksState {}

class BooksLoading extends BooksState {}

class BooksLoaded extends BooksState {
  final List<dynamic> books;

  const BooksLoaded({required this.books});

  @override
  List<dynamic> get props => [books];

  @override
  String toString() => 'BooksLoaded { books: $books }';
}

class BooksError extends BooksState {
  final String message;

  const BooksError({required this.message});

  @override
  List<dynamic> get props => [message];

  @override
  String toString() => 'BooksError { message: $message }';
}