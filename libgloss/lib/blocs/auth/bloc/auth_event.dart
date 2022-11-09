part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class VerifyAuthEvent extends AuthEvent {}

class AnonymousAuthEvent extends AuthEvent {}

class GoogleAuthEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
