import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trackers_event.dart';
part 'trackers_state.dart';

class TrackersBloc extends Bloc<TrackersEvent, TrackersState> {
  TrackersBloc() : super(TrackersInitial()) {
    on<TrackersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
