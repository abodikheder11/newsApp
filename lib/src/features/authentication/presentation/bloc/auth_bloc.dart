import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/src/features/authentication/domain/models/user_model.dart';
import 'package:news_app/src/features/authentication/domain/repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  StreamSubscription<UserModel?>? _userSubscription;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<GoogleSignInRequested>(googleSignInRequested);
    on<CheckAuthStatus>(_checkAuthStatus);
    on<UserChanged>(_handleUserChanged);
    on<UserLoggedOut>(_handleUserLoggedOut);
    Future.delayed(Duration.zero, () {
      _userSubscription = repository.user.listen((user) {
        if (user != null) {
          add(UserChanged(user));
        } else {
          if (state is Authenticated) {
            add(UserLoggedOut());
          }
        }
      });
    });
  }

  Future<void> googleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final user = await repository.signInWithGoogle();
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _checkAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await repository.getCurrentUser();
      user != null ? emit(Authenticated(user)) : emit(AuthInitial());
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  void _handleUserLoggedOut(
      UserLoggedOut event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await repository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _handleUserChanged(
    UserChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(Authenticated(event.user));
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
