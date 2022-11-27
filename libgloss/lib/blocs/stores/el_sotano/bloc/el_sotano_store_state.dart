part of 'el_sotano_store_bloc.dart';

@immutable
abstract class ElSotanoStoreState {
  const ElSotanoStoreState();

  List<dynamic> get props => [];
}

class ElSotanoStoreInitial extends ElSotanoStoreState {}

class ElSotanoStoreLoading extends ElSotanoStoreState {}

class ElSotanoStoreLoaded extends ElSotanoStoreState {
  final Map<String, dynamic> bookPrice;

  const ElSotanoStoreLoaded({
    required Map<String, dynamic> this.bookPrice,
  });

  @override
  List<dynamic> get props => [
        bookPrice,
      ];

  @override
  String toString() => 'ElSotanoStoreLoaded { bookPrice: $bookPrice }';
}

class ElSotanoStoreError extends ElSotanoStoreState {
  final String message;

  const ElSotanoStoreError({
    required String this.message,
  });

  @override
  List<dynamic> get props => [
        message,
      ];

  @override
  String toString() => 'ElSotanoStoreError { message: $message }';
}
