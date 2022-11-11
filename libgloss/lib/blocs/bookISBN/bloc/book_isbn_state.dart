part of 'book_isbn_bloc.dart';

@immutable
abstract class BookIsbnState {
  const BookIsbnState();

  List<dynamic> get props => [];
}

class BookIsbnInitial extends BookIsbnState {}

class BookIsbnLoading extends BookIsbnState {}

class BookIsbnLoaded extends BookIsbnState {
  final List<dynamic> bookDetails;

  const BookIsbnLoaded({required this.bookDetails});

  @override
  List<dynamic> get props => [bookDetails];

  @override
  String toString() => 'BookIsbnLoaded { bookDetails: $bookDetails }';
}

class BookIsbnError extends BookIsbnState {
  final String message;

  const BookIsbnError({required this.message});

  @override
  List<dynamic> get props => [message];

  @override
  String toString() => 'BookIsbnError { message: $message }';
}
