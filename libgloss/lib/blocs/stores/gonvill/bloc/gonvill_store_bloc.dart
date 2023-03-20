import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:libgloss/config/routes.dart';

import 'package:http/http.dart' as http;

part 'gonvill_store_event.dart';
part 'gonvill_store_state.dart';

class GonvillStoreBloc extends Bloc<GonvillStoreEvent, GonvillStoreState> {
  GonvillStoreBloc() : super(GonvillStoreInitial()) {
    on<GonvillPriceEvent>(_getBookPrice);
  }

  FutureOr<void> _getBookPrice(event, emit) async {
    if (kDebugMode) print('\u001b[33m[GonvillStoreBloc] ${event}');
    emit(GonvillStoreLoading());

    String bookId = event.bookId;

    final uri =
        Uri.parse(Routes.api + 'books/details?isbn=$bookId&store=gonvill');

    try {
      if (kDebugMode) print('\u001b[33m[GonvillStoreBloc] uri: $uri');
      var response = await http.get(uri);

      if (kDebugMode)
        print('\u001b[33m[GonvillStoreBloc] response: ${response.body}');

      emit(GonvillStoreLoaded(
          bookPrice: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode)
        print('\u001b[33m[GonvillStoreBloc] An error occured: $e');
      emit(GonvillStoreError(message: e.toString()));
    }
  }
}
