import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'used_books_event.dart';
part 'used_books_state.dart';

class UsedBooksBloc extends Bloc<UsedBooksEvent, UsedBooksState> {
  UsedBooksBloc() : super(UsedBooksInitial()) {
    _getBooks();
  }

  void _getBooks() {
    return on<GetUsedBooksEvent>((event, emit) async {
      emit(UsedBooksLoading());

      List<Map<String, dynamic>> books = [];

      try {
        final QuerySnapshot snapshot =
            await FirebaseFirestore.instance.collection('books').get();

        snapshot.docs.forEach((doc) {
          books.add(doc.data() as Map<String, dynamic>);
        });

        emit(UsedBooksLoaded(usedBooks: books));
      } catch (e) {
        emit(UsedBooksError(message: e.toString()));
      }
    });
  }
}
