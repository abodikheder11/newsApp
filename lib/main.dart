import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/src/core/di/injection_container.dart';
import 'package:news_app/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:news_app/src/features/authentication/presentation/pages/signup_screen.dart';
import 'package:news_app/src/features/news/presentation/bloc/news_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<NewsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(CheckAuthStatus()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        title: 'Flutter Demo',
        home: SignupScreen(),
      ),
    );
  }
}
