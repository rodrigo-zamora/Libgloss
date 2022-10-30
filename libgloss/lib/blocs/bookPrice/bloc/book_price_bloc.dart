import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

import '../../../config/routes.dart';
import '../stores.dart';

part 'book_price_event.dart';
part 'book_price_state.dart';

class BookPriceBloc extends Bloc<BookPriceEvent, BookPriceState> {
  BookPriceBloc() : super(BookPriceInitial()) {
    on<GetBookPriceEvent>(_getBookPrice);
  }

  FutureOr<void> _getBookPrice(event, emit) async {
    if (kDebugMode) print('\u001b[33m[BookPriceBloc] ${event}');
    emit(BookPriceLoading());

    String bookId = (event as GetBookPriceEvent).bookId;
    String store = (event).store.name;

    print('\u001b[33m[BookPriceBloc] bookId: $bookId, store: $store');

    final uri = Uri.parse(LibglossRoutes.API +
        'books/details?isbn=$bookId&store=${store.toString()}');

    try {
      if (kDebugMode) print('\u001b[33m[BookPriceBloc] uri: $uri');
      var response = await http.get(uri);

      if (kDebugMode)
        print('\u001b[33m[BookPriceBloc] response: ${response.body}');

      emit(BookPriceLoaded(
          bookPrice: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode) print('\u001b[33m[BookPriceBloc] An error occured: $e');
      emit(BookPriceError(message: e.toString()));
    }
  }
}
