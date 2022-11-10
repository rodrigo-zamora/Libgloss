import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../config/routes.dart';

part 'book_isbn_event.dart';
part 'book_isbn_state.dart';

class BookIsbnBloc extends Bloc<BookIsbnEvent, BookIsbnState> {
  BookIsbnBloc() : super(BookIsbnInitial()) {
    on<GetBookDetailsEvent>(_getDetails);
    on<ClearBookDetailsEvent>(_clearDetails);
  }

  Future<FutureOr<void>> _getDetails(event, emit) async {
    if (state != BookIsbnLoading) if (kDebugMode)
      print('\x1B[32m[BookISBNBloc] ${event}');
    emit(BookIsbnLoading());

    String isbn = (event as GetBookDetailsEvent).isbn;

    final uri = Uri.parse(LibglossRoutes.API + 'books/search?isbn=$isbn');

    try {
      if (kDebugMode) print('\x1B[32m[BookISBNBloc] uri: $uri');
      var response = await http.get(uri);
      print(response.body);

      if (response.statusCode == 404) {
        emit(BookIsbnError(message: 'No se han encontrado resultados'));
      } else {
        if (response.body == '[]') {
          emit(BookIsbnError(message: 'No se han encontrado resultados'));
        } else {
          var bookDetails = jsonDecode(response.body);
          emit(BookIsbnLoaded(bookDetails: bookDetails));
        }
      }
    } catch (e) {
      if (kDebugMode) print('\x1B[31m[BookISBNBloc] An error occured: $e');
      emit(BookIsbnError(message: e.toString()));
    }
  }

  FutureOr<void> _clearDetails(
      ClearBookDetailsEvent event, Emitter<BookIsbnState> emit) {
    if (kDebugMode) print('\x1B[32m[BookISBNBloc] ${event}');
    emit(BookIsbnInitial());
  }
}
