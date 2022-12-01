part of 'used_books_bloc.dart';

@immutable
abstract class UsedBooksEvent {
  const UsedBooksEvent();

  List<dynamic> get props => [];
}

class GetUsedBooksEvent extends UsedBooksEvent {
  @override
  List<dynamic> get props => [];

  @override
  String toString() => 'GetUsedBooksEvent';
}
