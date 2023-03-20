import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/auth/bloc/auth_bloc.dart';
import 'package:libgloss/blocs/bookISBN/bloc/book_isbn_bloc.dart';
import 'package:libgloss/blocs/books/bloc/books_bloc.dart';
import 'package:libgloss/blocs/search/bloc/search_bloc.dart';
import 'package:libgloss/blocs/stores/amazon/bloc/amazon_store_bloc.dart';
import 'package:libgloss/blocs/stores/el_sotano/bloc/el_sotano_store_bloc.dart';
import 'package:libgloss/blocs/stores/gandhi/bloc/gandhi_store_bloc.dart';
import 'package:libgloss/blocs/stores/gonvill/bloc/gonvill_store_bloc.dart';
import 'package:libgloss/blocs/tracking/bloc/tracking_bloc.dart';
import 'package:libgloss/blocs/used_books/bloc/used_books_bloc.dart';
import 'package:libgloss/blocs/used_search_books/bloc/used_search_bloc.dart';

class BlocSettings {
  static Widget getBlocProviders(Widget app) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(VerifyAuthEvent()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<BooksBloc>(
          create: (context) => BooksBloc(),
        ),
        BlocProvider<BookIsbnBloc>(
          create: (context) => BookIsbnBloc(),
        ),
        BlocProvider<TrackingBloc>(
          create: (context) => TrackingBloc(),
        ),
        BlocProvider<UsedBooksBloc>(
          create: (context) => UsedBooksBloc(),
        ),
        BlocProvider<AmazonStoreBloc>(
          create: (context) => AmazonStoreBloc(),
        ),
        BlocProvider<GandhiStoreBloc>(
          create: (context) => GandhiStoreBloc(),
        ),
        BlocProvider<GonvillStoreBloc>(
          create: (context) => GonvillStoreBloc(),
        ),
        BlocProvider<ElSotanoStoreBloc>(
          create: (context) => ElSotanoStoreBloc(),
        ),
        BlocProvider<UsedSearchBloc>(
          create: (context) => UsedSearchBloc(),
        ),
      ],
      child: app,
    );
  }
}
