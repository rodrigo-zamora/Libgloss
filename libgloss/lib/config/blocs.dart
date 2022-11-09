import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/auth/bloc/auth_bloc.dart';
import 'package:libgloss/blocs/bookISBN/bloc/book_isbn_bloc.dart';
import 'package:libgloss/blocs/books/bloc/books_bloc.dart';

import '../blocs/bookPrice/bloc/book_price_bloc.dart';
import '../blocs/search/bloc/search_bloc.dart';

class BlocSettings {
  static Widget getBlocProviders(Widget app) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(VerifyAuthEvent()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => BooksBloc(),
        ),
        BlocProvider(
          create: (context) => BookPriceBloc(),
        ),
        BlocProvider(
          create: (context) => BookIsbnBloc(),
        ),
      ],
      child: app,
    );
  }
}
