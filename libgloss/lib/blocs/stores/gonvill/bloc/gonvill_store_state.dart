part of 'gonvill_store_bloc.dart';

@immutable
abstract class GonvillStoreState {
  const GonvillStoreState();

  List<dynamic> get props => [];
}

class GonvillStoreInitial extends GonvillStoreState {}

class GonvillStoreLoading extends GonvillStoreState {}

class GonvillStoreLoaded extends GonvillStoreState {
  final Map<String, dynamic> bookPrice;

  const GonvillStoreLoaded({
    required Map<String, dynamic> this.bookPrice,
  });

  @override
  List<dynamic> get props => [
        bookPrice,
      ];

  @override
  String toString() => 'GonvillStoreLoaded { bookPrice: $bookPrice }';
}

class GonvillStoreError extends GonvillStoreState {
  final String message;

  const GonvillStoreError({
    required String this.message,
  });

  @override
  List<dynamic> get props => [
        message,
      ];

  @override
  String toString() => 'GonvillStoreError { message: $message }';
}
