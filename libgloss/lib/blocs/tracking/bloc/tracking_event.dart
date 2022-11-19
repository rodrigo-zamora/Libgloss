part of 'tracking_bloc.dart';

@immutable
abstract class TrackingEvent {
  const TrackingEvent();

  @override
  List<Object> get props => [];
}

class UpdateTracking extends TrackingEvent {}
