part of 'used_books_bloc.dart';

@immutable
abstract class UsedBooksState {
  const UsedBooksState();

  List<dynamic> get props => [];
}

class UsedBooksInitial extends UsedBooksState {}

class UsedBooksLoading extends UsedBooksState {}

class UsedBooksLoaded extends UsedBooksState {
  final List<Map<String, dynamic>> usedBooks;

  const UsedBooksLoaded({required this.usedBooks});

  @override
  List<dynamic> get props => [usedBooks];

  @override
  String toString() => 'UsedBooksLoaded { usedBooks: $usedBooks }';
}

class UsedBooksError extends UsedBooksState {
  final String message;

  const UsedBooksError({required this.message});

  @override
  List<dynamic> get props => [message];

  @override
  String toString() => 'UsedBooksError { message: $message }';
}
