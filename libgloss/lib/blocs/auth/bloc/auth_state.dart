part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccessState extends AuthState {}

class UnAuthState extends AuthState {}

class SignOutSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AuthErrorState { message: $message }';
}

class AuthAwaitingState extends AuthState {}
