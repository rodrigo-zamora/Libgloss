import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  TrackingBloc() : super(TrackingInitial()) {
    on<UpdateTracking>((event, emit) {
      emit(TrackingUpdated());
    });
  }
}
