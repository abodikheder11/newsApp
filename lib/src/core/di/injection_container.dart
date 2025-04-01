import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/src/features/authentication/data/datasource/auth_remote_data_source.dart';
import 'package:news_app/src/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:news_app/src/features/authentication/domain/repository/auth_repository.dart';
import 'package:news_app/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:news_app/src/features/news/data/datasource/NewsDS.dart';
import 'package:news_app/src/features/news/data/repository/news_repository_impl.dart';
import 'package:news_app/src/features/news/domain/repository/news_repository.dart';
import 'package:news_app/src/features/news/presentation/bloc/news_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External services
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn());

  // Data Sources (register interfaces, not implementations)
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
    ),
  );

  sl.registerLazySingleton<NewsDataSource>(
    () => NewsDataSourceImpl(), // Register interface type
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(remoteDS: sl()), // Match parameter name
  );

  // BLoCs
  sl.registerFactory(() => AuthBloc(sl()));
  sl.registerFactory(() => NewsBloc(sl()));
}
