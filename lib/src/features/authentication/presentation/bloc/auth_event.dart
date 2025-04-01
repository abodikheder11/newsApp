part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  List<Object> get props => [];
}

class GoogleSignInRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class UserChanged extends AuthEvent {
  final UserModel user;

  UserChanged(this.user);
}

class UserLoggedOut extends AuthEvent {}
