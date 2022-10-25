import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/data/cubits/auth_cubit/auth_cubit.dart';
import 'package:task_project/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:task_project/data/models/message_item.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User?>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Page"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().signOut(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      // body:
    );
  }
}
