import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/data/cubits/auth_cubit/auth_cubit.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Page"),
        actions: [
          IconButton(onPressed: (){
            context.read<AuthCubit>().signOut(context);
          }, icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
