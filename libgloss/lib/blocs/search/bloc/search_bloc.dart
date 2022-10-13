import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>(_searchBook);
  }

  // TODO: Add BOOK API
  final BOOK_API = '';

  FutureOr<void> _searchBook(SearchEvent event, Emitter emit) async {
    if (kDebugMode) print('[SearchBloc] ${event}');
    emit(SearchLoading());

    Timer? _timer;
    int _recordDuration = 10;
    int _current = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _current++;
        print("\t\tTime recorded: $_current");
        if (_current >= _recordDuration) {
          _timer?.cancel();
          _timer = null;
          _current = 0;
          print("\t\tTimer cancelled");
        }
      });
    await Future.delayed(Duration(seconds: 10));
    emit(SearchTempLoaded());
    // TODO: Add API call
    //emit(SearchLoaded(books: []));
  }
}
