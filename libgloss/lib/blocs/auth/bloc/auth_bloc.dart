import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:libgloss/config/routes.dart';

import '../../../repositories/auth/user_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserAuthRepository _authRepo = UserAuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<VerifyAuthEvent>(_authVerfication);
    on<GoogleAuthEvent>(_authUser);
    on<FacebookAuthEvent>(_authFacebook);
    on<SignOutEvent>(_signOut);
  }

  FutureOr<void> _authVerfication(event, emit) {
    if (_authRepo.isAuthenticated()) {
      emit(AuthSuccessState());
    } else {
      emit(UnAuthState());
    }
  }

  FutureOr<void> _signOut(event, emit) async {
    try {
      print('signing out');

      await _authRepo.signOut();

      print('signed out');

      print('Sign out success');

      ScaffoldMessenger.of(event.buildcontext)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Has cerrado sesión'),
          ),
        );

      Routes.currentRoute = Routes.newBooks;

      Navigator.pushAndRemoveUntil(
          event.buildcontext,
          PageRouteBuilder(pageBuilder: (BuildContext context,
              Animation animation, Animation secondaryAnimation) {
            return Routes.getRoute(Routes.newBooks);
          }, transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          }),
          (Route route) => false);

      emit(SignOutSuccessState());
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _authUser(event, emit) async {
    emit(AuthAwaitingState());
    try {
      // TODO: Implement auth here
      await _authRepo.signInWithGoogle();
      ScaffoldMessenger.of(event.buildcontext)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Has iniciado sesión'),
          ),
        );

      Routes.currentRoute = Routes.newBooks;

      Navigator.pushAndRemoveUntil(
          event.buildcontext,
          PageRouteBuilder(pageBuilder: (BuildContext context,
              Animation animation, Animation secondaryAnimation) {
            return Routes.getRoute(Routes.newBooks);
          }, transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          }),
          (Route route) => false);

      emit(AuthSuccessState());
    } catch (e) {
      ScaffoldMessenger.of(event.buildcontext)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error al iniciar sesión: $e'),
          ),
        );
      emit(AuthErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _authFacebook(event, emit) async {
    emit(AuthAwaitingState());
    try {
      // TODO: Implement auth here
      await _authRepo.signInWithFacebook();
      ScaffoldMessenger.of(event.buildcontext)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Has iniciado sesión'),
          ),
        );

      Routes.currentRoute = Routes.newBooks;

      Navigator.pushAndRemoveUntil(
          event.buildcontext,
          PageRouteBuilder(pageBuilder: (BuildContext context,
              Animation animation, Animation secondaryAnimation) {
            return Routes.getRoute(Routes.newBooks);
          }, transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          }),
          (Route route) => false);

      emit(AuthSuccessState());
    } catch (e) {
      ScaffoldMessenger.of(event.buildcontext)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error al iniciar sesión: $e'),
          ),
        );
      emit(AuthErrorState(message: e.toString()));
    }
  }
}
