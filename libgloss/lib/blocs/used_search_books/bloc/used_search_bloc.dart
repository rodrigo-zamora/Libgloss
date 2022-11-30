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

    String search = event.query;

    Map<String, dynamic> filters = event.filters;
    print(filters);

    if (filters.isEmpty) {
      try {
        final QuerySnapshot snapshot =
            await FirebaseFirestore.instance.collection('books').get();

        print(snapshot.docs);

        snapshot.docs.forEach((doc) {
          Map<String, dynamic> book = doc.data() as Map<String, dynamic>;
          if (book['title'].toString().toLowerCase().trim().contains(search)) {
            books.add(book);
          }
        });

        emit(UsedSearchLoaded(usedBooks: books));
      } catch (e) {
        emit(UsedSearchError(message: e.toString()));
      }
    } else {
      try {
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('books')
            .where('authors', arrayContains: filters['author'])
            .where('categories', arrayContains: filters['category'])
            .where('publisher', isEqualTo: filters['publisher'])
            .get();

        print(snapshot.docs);

        snapshot.docs.forEach((doc) {
          Map<String, dynamic> book = doc.data() as Map<String, dynamic>;
          books.add(book);
        });

        emit(UsedSearchLoaded(usedBooks: books));
      } catch (e) {
        emit(UsedSearchError(message: e.toString()));
      }
    }
  }
}
