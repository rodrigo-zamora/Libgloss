import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('books').get();

      snapshot.docs.forEach((doc) {
        books.add(doc.data() as Map<String, dynamic>);
      });

      emit(UsedSearchLoaded(usedBooks: books));
    } catch (e) {
      emit(UsedSearchError(message: e.toString()));
    }
  }
}
