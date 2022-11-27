import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:libgloss/config/routes.dart';

import 'package:http/http.dart' as http;

part 'amazon_store_event.dart';
part 'amazon_store_state.dart';

class AmazonStoreBloc extends Bloc<AmazonStoreEvent, AmazonStoreState> {
  AmazonStoreBloc() : super(AmazonStoreInitial()) {
    on<AmazonPriceEvent>(_getBookPrice);
  }

  Future<FutureOr<void>> _getBookPrice(event, emit) async {
    if (kDebugMode) print('\u001b[33m[AmazonStoreBloc] ${event}');
    emit(AmazonStoreLoading());

    String bookId = event.bookId;

    final uri = Uri.parse(
        LibglossRoutes.API + 'books/details?isbn=$bookId&store=amazon');

    try {
      if (kDebugMode) print('\u001b[33m[AmazonStoreBloc] uri: $uri');
      var response = await http.get(uri);

      if (kDebugMode)
        print('\u001b[33m[AmazonStoreBloc] response: ${response.body}');

      emit(AmazonStoreLoaded(
          bookPrice: response.body == '[]' ? [] : jsonDecode(response.body)));
    } catch (e) {
      if (kDebugMode) print('\u001b[33m[AmazonStoreBloc] An error occured: $e');
      emit(AmazonStoreError(message: e.toString()));
    }
  }
}
