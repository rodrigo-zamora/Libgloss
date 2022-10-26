part of 'books_bloc.dart';

@immutable
abstract class BooksEvent {
  const BooksEvent();

  List<dynamic> get props => [];
}

class GetTopBooksEvent extends BooksEvent {}