part of 'el_sotano_store_bloc.dart';

@immutable
abstract class ElSotanoStoreEvent {
  const ElSotanoStoreEvent();

  List<dynamic> get props => [];
}

class ElSotanoPriceEvent extends ElSotanoStoreEvent {
  final String bookId;

  const ElSotanoPriceEvent({
    required String this.bookId,
  });

  @override
  List<dynamic> get props => [
        bookId,
      ];

  @override
  String toString() => 'GetBookPriceEvent { bookId: $bookId }';
}
