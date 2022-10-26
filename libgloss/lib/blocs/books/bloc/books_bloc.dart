import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

import '../../../config/routes.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc() : super(BooksInitial()) {
    on<GetTopBooksEvent>(_getTopBooks);
  }

  FutureOr<void> _getTopBooks(event, emit) async {
    if (kDebugMode) print('\u001b[33m[BooksBloc] ${event}');
    emit(BooksLoading());

    final uri = Uri.parse(LibglossRoutes.API + 'books/top');

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
}