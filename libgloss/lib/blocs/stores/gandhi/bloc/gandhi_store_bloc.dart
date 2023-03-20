import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:libgloss/config/routes.dart';

import 'package:http/http.dart' as http;

part 'gandhi_store_event.dart';
part 'gandhi_store_state.dart';

class GandhiStoreBloc extends Bloc<GandhiStoreEvent, GandhiStoreState> {
  GandhiStoreBloc() : super(GandhiStoreInitial()) {
    on<GandhiPriceEvent>(_getBookPrice);
  }

  FutureOr<void> _getBookPrice(event, emit) async {
    if (kDebugMode) print('\u001b[33m[GandhiStoreBloc] ${event}');
    emit(GandhiStoreLoading());

    String bookId = event.bookId;

    final uri =
        Uri.parse(Routes.api + 'books/details?isbn=$bookId&store=gandhi');

    try {
      if (kDebugMode) print('\u001b[33m[GandhiStoreBloc] uri: $uri');
      var response = await http.get(uri);

      if (kDebugMode)
        print('\u001b[33m[GandhiStoreBloc] response: ${response.body}');

      emit(GandhiStoreLoaded(
          bookPrice: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode) print('\u001b[33m[GandhiStoreBloc] An error occured: $e');
      emit(GandhiStoreError(message: e.toString()));
    }
  }
}
