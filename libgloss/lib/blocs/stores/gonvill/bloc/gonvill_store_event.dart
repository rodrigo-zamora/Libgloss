part of 'gonvill_store_bloc.dart';

@immutable
abstract class GonvillStoreEvent {
  const GonvillStoreEvent();

  List<dynamic> get props => [];
}

class GonvillPriceEvent extends GonvillStoreEvent {
  final String bookId;

  const GonvillPriceEvent({
    required String this.bookId,
  });

  @override
  List<dynamic> get props => [
        bookId,
      ];

  @override
  String toString() => 'GetBookPriceEvent { bookId: $bookId }';
}
