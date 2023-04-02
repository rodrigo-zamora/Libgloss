part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();

  List<Object> get props => [];
}

class VerifyAuthEvent extends AuthEvent {}

class AnonymousAuthEvent extends AuthEvent {}

class GoogleAuthEvent extends AuthEvent {
  final BuildContext buildcontext;

  GoogleAuthEvent({required this.buildcontext});
}

class FacebookAuthEvent extends AuthEvent {
  final BuildContext buildcontext;

  FacebookAuthEvent({required this.buildcontext});
}

class SignOutEvent extends AuthEvent {
  final BuildContext buildcontext;

  SignOutEvent({required this.buildcontext});
}
