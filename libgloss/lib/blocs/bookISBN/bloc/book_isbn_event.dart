part of 'book_isbn_bloc.dart';

@immutable
abstract class BookIsbnEvent {
  const BookIsbnEvent();

  List<dynamic> get props => [];
}

class GetBookDetailsEvent extends BookIsbnEvent {
  final String isbn;

  const GetBookDetailsEvent({
    required String this.isbn,
  });

  @override
  List<dynamic> get props => [
        isbn,
      ];

  @override
  String toString() => 'GetBookDetailsEvent { isbn: $isbn }';
}

class ClearBookDetailsEvent extends BookIsbnEvent {
  const ClearBookDetailsEvent();

  @override
  String toString() => 'ClearBookDetailsEvent';
}
