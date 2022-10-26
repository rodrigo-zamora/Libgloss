part of 'book_price_bloc.dart';

@immutable
abstract class BookPriceState {
  const BookPriceState();

  List<dynamic> get props => [];
}

class BookPriceInitial extends BookPriceState {}

class BookPriceLoading extends BookPriceState {}

class BookPriceLoaded extends BookPriceState {
  final Map<String, dynamic> bookPrice;

  const BookPriceLoaded({required this.bookPrice});

  @override
  List<dynamic> get props => [bookPrice];

  @override
  String toString() => 'BookPriceLoaded { bookPrice: $bookPrice }';
}

class BookPriceError extends BookPriceState {
  final String message;

  const BookPriceError({required this.message});

  @override
  List<dynamic> get props => [message];

  @override
  String toString() => 'BookPriceError { message: $message }';
}
