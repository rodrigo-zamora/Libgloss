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

  FutureOr<void> _searchBook(SearchEvent event, Emitter emit) {
    if (kDebugMode) print('[SearchBloc] ${event}');
    emit(SearchLoading());

    // TODO: Add API call
    //emit(SearchLoaded(books: []));
  }
}
