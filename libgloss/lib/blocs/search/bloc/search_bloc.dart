import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../../../config/routes.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>(_searchBook);
    on<BookDetailsEvent>(_bookDetails);
  }

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
      uri = Uri.parse(LibglossRoutes.API + 'books/search?$filterQuery');
    } else {
      uri = Uri.parse(
          LibglossRoutes.API + 'books/search?title=$query' + filterQuery);
    }

    try {
      if (kDebugMode) print('\x1B[32m[SearchBloc] uri: $uri');
      var response = await http.get(uri);
      print(response.body);
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

    final uri = Uri.parse(LibglossRoutes.API + 'books/$bookId');

    try {
      if (kDebugMode) print('\x1B[32m[SearchBloc] uri: $uri');
      var response = await http.get(uri);
      print(response.body);
      emit(BookLoaded(
          bookDetails: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode) print('\x1B[31m[SearchBloc] An error occured: $e');
      emit(SearchError(message: e.toString()));
    }

    emit(BookLoaded(bookDetails: {}));
  }
}
