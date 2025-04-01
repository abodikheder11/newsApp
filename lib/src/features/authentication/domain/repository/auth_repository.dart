import 'package:news_app/src/features/authentication/domain/models/user_model.dart';

abstract class AuthRepository {
  Stream<UserModel?> get user;

  Future<UserModel> signInWithGoogle();

  Future<UserModel?> getCurrentUser();

  Future<void> signOut();
}
