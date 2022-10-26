part of 'books_bloc.dart';

@immutable
abstract class BooksEvent {
  const BooksEvent();

  List<dynamic> get props => [];
}

class GetTopBooksEvent extends BooksEvent {}

class GetBookPriceEvent extends BooksEvent {
  final String bookId;

  const GetBookPriceEvent({
    required String this.bookId,
  });

  @override
  List<dynamic> get props => [
        bookId,
      ];

  @override
  String toString() => 'GetBookPriceEvent { bookId: $bookId }';
}
