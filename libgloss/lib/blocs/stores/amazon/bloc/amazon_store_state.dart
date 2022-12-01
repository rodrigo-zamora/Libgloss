part of 'amazon_store_bloc.dart';

@immutable
abstract class AmazonStoreState {
  const AmazonStoreState();

  List<dynamic> get props => [];
}

class AmazonStoreInitial extends AmazonStoreState {}

class AmazonStoreLoading extends AmazonStoreState {}

class AmazonStoreLoaded extends AmazonStoreState {
  final Map<String, dynamic> bookPrice;

  const AmazonStoreLoaded({
    required Map<String, dynamic> this.bookPrice,
  });

  @override
  List<dynamic> get props => [
        bookPrice,
      ];

  @override
  String toString() => 'AmazonStoreLoaded { bookPrice: $bookPrice }';
}

class AmazonStoreError extends AmazonStoreState {
  final String message;

  const AmazonStoreError({
    required String this.message,
  });

  @override
  List<dynamic> get props => [
        message,
      ];

  @override
  String toString() => 'AmazonStoreError { message: $message }';
}
