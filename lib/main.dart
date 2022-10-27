import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_project/data/cubits/auth_cubit/auth_cubit.dart';
import 'package:task_project/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:task_project/data/cubits/users_cubit/users_cubit.dart';
import 'package:task_project/ui/auth/pages/auth_page.dart';
import 'package:task_project/ui/chat/chat.dart';
import 'package:task_project/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(fireAuth: FirebaseAuth.instance)),
        BlocProvider(create: (context) => ChatCubit(fireStore: FirebaseFirestore.instance)),
        BlocProvider(create: (context) => UserCubit(fireStore: FirebaseFirestore.instance)),
      ],
      child: StreamProvider(
        create: (context) => context.read<AuthCubit>().authState(),
        initialData: null,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const MainPage(),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const ChatPage();
    }
    return const AuthPage();
  }
}
