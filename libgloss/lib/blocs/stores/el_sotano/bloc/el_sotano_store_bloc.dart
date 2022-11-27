import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:libgloss/config/routes.dart';

import 'package:http/http.dart' as http;

part 'el_sotano_store_event.dart';
part 'el_sotano_store_state.dart';

class ElSotanoStoreBloc extends Bloc<ElSotanoStoreEvent, ElSotanoStoreState> {
  ElSotanoStoreBloc() : super(ElSotanoStoreInitial()) {
    on<ElSotanoPriceEvent>(_getBookPrice);
  }

  FutureOr<void> _getBookPrice(event, emit) async {
    if (kDebugMode) print('\u001b[33m[ElSotanoStoreBloc] ${event}');
    emit(ElSotanoStoreLoading());

    String bookId = event.bookId;

    final uri = Uri.parse(
        LibglossRoutes.API + 'books/details?isbn=$bookId&store=el_sotano');

    try {
      if (kDebugMode) print('\u001b[33m[ElSotanoStoreBloc] uri: $uri');
      var response = await http.get(uri);

      if (kDebugMode)
        print('\u001b[33m[ElSotanoStoreBloc] response: ${response.body}');

      emit(ElSotanoStoreLoaded(
          bookPrice: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode)
        print('\u001b[33m[ElSotanoStoreBloc] An error occured: $e');
      emit(ElSotanoStoreError(message: e.toString()));
    }
  }
}
