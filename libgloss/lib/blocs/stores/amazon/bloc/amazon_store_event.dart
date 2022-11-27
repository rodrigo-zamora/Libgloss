part of 'amazon_store_bloc.dart';

@immutable
abstract class AmazonStoreEvent {
  const AmazonStoreEvent();

  List<dynamic> get props => [];
}

class AmazonPriceEvent extends AmazonStoreEvent {
  final String bookId;

  const AmazonPriceEvent({
    required String this.bookId,
  });

  @override
  List<dynamic> get props => [
        bookId,
      ];

  @override
  String toString() => 'GetBookPriceEvent { bookId: $bookId }';
}
