part of 'gandhi_store_bloc.dart';

@immutable
abstract class GandhiStoreState {
  const GandhiStoreState();

  List<dynamic> get props => [];
}

class GandhiStoreInitial extends GandhiStoreState {}

class GandhiStoreLoading extends GandhiStoreState {}

class GandhiStoreLoaded extends GandhiStoreState {
  final Map<String, dynamic> bookPrice;

  const GandhiStoreLoaded({
    required Map<String, dynamic> this.bookPrice,
  });

  @override
  List<dynamic> get props => [
        bookPrice,
      ];

  @override
  String toString() => 'GandhiStoreLoaded { bookPrice: $bookPrice }';
}

class GandhiStoreError extends GandhiStoreState {
  final String message;

  const GandhiStoreError({
    required String this.message,
  });

  @override
  List<dynamic> get props => [
        message,
      ];

  @override
  String toString() => 'GandhiStoreError { message: $message }';
}
