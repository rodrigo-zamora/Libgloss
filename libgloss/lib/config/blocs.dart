import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/books/bloc/books_bloc.dart';

import '../blocs/preferences/bloc/preferences_bloc.dart';
import '../blocs/search/bloc/search_bloc.dart';

class Bloc {
  static Widget getBlocProviders(Widget app) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => PreferencesBloc(),
        ),
        BlocProvider(
          create: (context) => BooksBloc(),
        ),
      ],
      child: app,
    );
  }
}
