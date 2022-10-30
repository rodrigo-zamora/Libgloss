part of 'book_price_bloc.dart';

@immutable
abstract class BookPriceEvent {
  const BookPriceEvent();

  List<dynamic> get props => [];
}

class GetBookPriceEvent extends BookPriceEvent {
  final String bookId;
  final Store store;

  const GetBookPriceEvent({
    required String this.bookId,
    required Store this.store,
  });

  @override
  List<dynamic> get props => [
        bookId,
      ];

  @override
  String toString() => 'GetBookPriceEvent { bookId: $bookId, store: $store }';
}
