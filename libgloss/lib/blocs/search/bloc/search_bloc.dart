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
    on<BookDetailsEvent>(_bookDetails);
  }

  final BOOK_API = 'https://libgloss.herokuapp.com/api/';

  FutureOr<void> _searchBook(SearchEvent event, Emitter emit) async {
    if (kDebugMode) print('\x1B[32m[SearchBloc] ${event}');
    emit(SearchLoading());

    String query = (event as SearchBoookEvent).query;
    Map<String, dynamic> filters = (event).filters;

    String filterQuery = '';
    filters.forEach((key, value) {
      if (value != null) {
        filterQuery += '&$key=$value';
      }
    });

    var uri;

    if (query == '') {
      uri = Uri.parse(BOOK_API + 'books/search?$filterQuery');
    } else {
      uri = Uri.parse(BOOK_API + 'books/search?title=$query' + filterQuery);
    }

    try {
      if (kDebugMode) print('\x1B[32m[SearchBloc] uri: $uri');
      var response = await http.get(uri);
      emit(SearchLoaded(
          books: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode) print('\x1B[31m[SearchBloc] An error occured: $e');
      emit(SearchError(message: e.toString()));
    }
  }

  FutureOr<void> _bookDetails(SearchEvent event, Emitter emit) async {
    if (kDebugMode) print('\x1B[32m[SearchBloc] ${event}');
    emit(BookLoading());

    String bookId = (event as BookDetailsEvent).bookId;

    final uri = Uri.parse(BOOK_API + 'books/$bookId');

    try {
      if (kDebugMode) print('\x1B[32m[SearchBloc] uri: $uri');
      var response = await http.get(uri);
      emit(BookLoaded(
          bookDetails: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode) print('\x1B[31m[SearchBloc] An error occured: $e');
      emit(SearchError(message: e.toString()));
    }

    emit(BookLoaded(bookDetails: {}));
  }
}
