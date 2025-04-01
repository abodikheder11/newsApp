import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/src/features/authentication/domain/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Stream<User?> get user;

  Future<User> signInWithGoogle();

  Future<User?> getCurrentUser();

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl(
      {required FirebaseAuth firebaseAuth, required GoogleSignIn googleSignIn})
      : firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  @override
  Stream<User?> get user => firebaseAuth.authStateChanges();

  @override
  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception("Google sign in has canceled");
    }
    final googleAuth = await googleUser.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredentials =
        await firebaseAuth.signInWithCredential(credentials);
    return userCredentials.user!;
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    firebaseAuth.currentUser;
  }
}
