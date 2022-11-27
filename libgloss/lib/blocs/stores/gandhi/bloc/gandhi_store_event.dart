part of 'gandhi_store_bloc.dart';

@immutable
abstract class GandhiStoreEvent {
  const GandhiStoreEvent();

  List<dynamic> get props => [];
}

class GandhiPriceEvent extends GandhiStoreEvent {
  final String bookId;

  const GandhiPriceEvent({
    required String this.bookId,
  });

  @override
  List<dynamic> get props => [
        bookId,
      ];

  @override
  String toString() => 'GetBookPriceEvent { bookId: $bookId }';
}
