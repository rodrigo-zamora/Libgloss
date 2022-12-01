import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../config/routes.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc() : super(BooksInitial()) {
    on<GetTopBooksEvent>(_getTopBooks);
    on<GetRandomBooksEvent>(_getRandomBooks);
  }

  FutureOr<void> _getTopBooks(
      GetTopBooksEvent event, Emitter<BooksState> emit) async {
    if (kDebugMode) print('\u001b[33m[BooksBloc] ${event}');
    emit(BooksLoading());

    final uri = Uri.parse(LibglossRoutes.API +
        'books?page_size=' +
        event.page_size.toString() +
        '&page=' +
        event.page.toString());

    try {
      if (kDebugMode) print('\u001b[33m[BooksBloc] uri: $uri');
      var response = await http.get(uri);
      emit(BooksLoaded(
          books: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode) print('\u001b[33m[BooksBloc] An error occured: $e');
      emit(BooksError(message: e.toString()));
    }
  }

  FutureOr<void> _getRandomBooks(
      GetRandomBooksEvent event, Emitter<BooksState> emit) async {
    if (kDebugMode) print('\u001b[33m[BooksBloc] ${event}');
    emit(BooksLoading());

    final uri = Uri.parse(LibglossRoutes.API +
        'books/random?page_size=' +
        event.page_size.toString());

    try {
      if (kDebugMode) print('\u001b[33m[BooksBloc] uri: $uri');
      var response = await http.get(uri);
      //print(response.body);
      emit(BooksLoaded(
          books: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode) print('\u001b[33m[BooksBloc] An error occured: $e');
      emit(BooksError(message: e.toString()));
    }
  }
}
