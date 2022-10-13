import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsMoveEvent>(_move);
  }

  FutureOr<void> _move (DetailsMoveEvent event, Emitter<DetailsState> emit) async {
    emit(DetailsLoadingState());
    var _list = event.props[0];
    _list = Map<String, dynamic>.from(_list as Map<String, dynamic>);
    print(_list);
    emit(DetailsLoadedState(list: _list));
  }
}
