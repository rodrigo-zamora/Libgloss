import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc() : super(BooksInitial()) {
    on<GetTopBooksEvent>(_getTopBooks);
  }

  final BOOK_API = 'https://libgloss.herokuapp.com/api/';

  FutureOr<void> _getTopBooks(event, emit) async {
    if (kDebugMode) print('\x1B[32m[SearchBloc] ${event}');
    emit(BooksLoading());

    final uri = Uri.parse(BOOK_API + 'books/top');

    try {
      if (kDebugMode) print('\x1B[32m[SearchBloc] uri: $uri');
      var response = await http.get(uri);
      emit(BooksLoaded(
          books: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode) print('\x1B[31m[SearchBloc] An error occured: $e');
      emit(BooksError(message: e.toString()));
    }
  }
}
