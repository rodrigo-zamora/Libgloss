import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>(_searchBook);
  }

  final BOOK_API = 'https://libgloss.herokuapp.com/api/books/search';

  FutureOr<void> _searchBook(SearchEvent event, Emitter emit) async {
    if (kDebugMode) print('\x1B[32m[SearchBloc] ${event}');
    emit(SearchLoading());

    try {
      final uri = Uri.parse(BOOK_API + '?title=${event.props[0]}');
      if (kDebugMode) print('\x1B[32m[SearchBloc] uri: $uri');
      var response = await http.get(uri);
      emit(SearchLoaded(
          books: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode) print('\x1B[31m[SearchBloc] An error occured: $e');
      emit(SearchError(message: e.toString()));
    }
  }
}
