import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'used_search_event.dart';
part 'used_search_state.dart';

class UsedSearchBloc extends Bloc<UsedSearchEvent, UsedSearchState> {
  UsedSearchBloc() : super(UsedSearchInitial()) {
    on<SearchUsedBooksEvent>(_searchBooks);
  }

  FutureOr<void> _searchBooks(event, emit) async {
    emit(UsedSearchLoading());

    List<Map<String, dynamic>> books = [];

    String search = event.query;

    Map<String, dynamic> filters = event.filters;
    print(filters);

    if (filters.isEmpty) {
      try {
        // TODO: Get all used books from Amplify database using empty filters

        emit(UsedSearchLoaded(usedBooks: books));
      } catch (e) {
        emit(UsedSearchError(message: e.toString()));
      }
    } else {
      try {
        // TODO: Get all used books from Amplify database using filters

        emit(UsedSearchLoaded(usedBooks: books));
      } catch (e) {
        emit(UsedSearchError(message: e.toString()));
      }
    }
  }
}
