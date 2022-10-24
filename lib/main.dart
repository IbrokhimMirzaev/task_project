import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_project/data/cubits/auth_cubit/auth_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(fireAuth: FirebaseAuth.instance)),
      ],
      child: StreamProvider(
        create: (context) => context.read<AuthCubit>().authState(),
        initialData: null,
        child: MaterialApp(
          // home:
        ),
      ),
    );
  }
}
