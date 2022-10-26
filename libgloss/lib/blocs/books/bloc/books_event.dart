part of 'books_bloc.dart';

@immutable
abstract class BooksEvent {
  const BooksEvent();

  List<dynamic> get props => [];
}

class GetTopBooksEvent extends BooksEvent {
  final int page_size;
  final int page;

  const GetTopBooksEvent({
    required int this.page_size,
    required int this.page,
  });

  @override
  List<dynamic> get props => [
        page_size,
        page,
      ];

  @override
  String toString() =>
      'GetTopBooksEvent { page_size: $page_size, page: $page }';
}

class GetRandomBooksEvent extends BooksEvent {
  final int page_size;

  const GetRandomBooksEvent({
    required int this.page_size,
  });

  @override
  List<dynamic> get props => [
        page_size,
      ];

  @override
  String toString() => 'GetRandomBooksEvent { page_size: $page_size }';
}
