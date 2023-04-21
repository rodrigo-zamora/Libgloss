import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:libgloss/models/ModelProvider.dart';
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
        final req = ModelQueries.list<UserBooks>(UserBooks.classType);
        final res = await Amplify.API.query(request: req).response;

        res.data!.items.forEach((item) => {books.add(item!.toJson())});

        emit(UsedBooksLoaded(usedBooks: books));
      } catch (e) {
        emit(UsedBooksError(message: e.toString()));
      }
    });
  }
}
