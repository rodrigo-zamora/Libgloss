import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/search/bloc/search_bloc.dart';

class Bloc {
  static Widget getBlocProviders(Widget app) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: app,
    );
  }
}
