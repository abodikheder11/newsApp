import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/src/features/authentication/data/datasource/auth_remote_data_source.dart';
import 'package:news_app/src/features/authentication/data/mappers/user_mapper.dart';
import 'package:news_app/src/features/authentication/domain/models/user_model.dart';
import 'package:news_app/src/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<UserModel?> get user {
    return remoteDataSource.user.map((user) {
      return user != null ? UserModel.fromFirebase(user) : null;
    });
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final user = await remoteDataSource.signInWithGoogle();
    return UserModel.fromFirebase(user);
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = await remoteDataSource.getCurrentUser();
    return user != null ? UserModel.fromFirebase(user) : null;
  }
}
