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
    on<GetBookPriceEvent>(_getBookPrice);
  }

  final BOOK_API = 'https://libgloss.herokuapp.com/api/';

  FutureOr<void> _getTopBooks(event, emit) async {
    if (kDebugMode) print('\u001b[33m[BooksBloc] ${event}');
    emit(BooksLoading());

    final uri = Uri.parse(BOOK_API + 'books/top');

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

  FutureOr<void> _getBookPrice(event, emit) async {
    if (kDebugMode) print('\u001b[33m[BooksBloc] ${event}');
    emit(BookPriceLoading());

    String bookId = (event as GetBookPriceEvent).bookId;

    final uri = Uri.parse(BOOK_API + 'books/details?isbn=$bookId');

    try {
      if (kDebugMode) print('\u001b[33m[BooksBloc] uri: $uri');
      var response = await http.get(uri);
      emit(BookPriceLoaded(
          bookPrice: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode) print('\u001b[33m[BooksBloc] An error occured: $e');
      emit(BookPriceError(message: e.toString()));
    }
  }
}
