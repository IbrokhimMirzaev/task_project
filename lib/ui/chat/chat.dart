import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_project/data/cubits/auth_cubit/auth_cubit.dart';
import 'package:task_project/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:task_project/data/models/message_item.dart';
import 'package:task_project/ui/chat/widgets/left_side_message_item.dart';
import 'package:task_project/ui/chat/widgets/rightside_message_item.dart';
import 'package:task_project/utils/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User?>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Page"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.people),
          ),
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().signOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageItem>>(
              stream: context.read<ChatCubit>().getMessages(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  final messages = snapshot.data!;
                  return messages.isNotEmpty
                      ? ListView(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          children: List.generate(messages.length, (index) {
                            var message = messages[index];
                            return (message.uid == user!.uid)
                                ? RightSideMessageItem(
                                    dateText: DateFormat.Hm()
                                        .format(message.createdAt),
                                    messageText: message.message,
                                  )
                                : LeftSideMessageItem(
                                    dateText: DateFormat.Hm()
                                        .format(message.createdAt),
                                    messageText: message.message,
                                  );
                          }),
                        )
                      : const Center(child: Text("List Empty"));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    onChanged: (v) {
                      if (v.length <= 1) {
                        setState(() {});
                      }
                    },
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 2, color: MyColors.C_0001FC),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    context.read<ChatCubit>().sendMessage(
                          messageItem: MessageItem(
                            uid: user!.uid,
                            message: controller.text,
                            createdAt: DateTime.now(),
                            messageId: "",
                            senderName: user.email!,
                          ),
                        );

                    controller.clear();
                    focusNode.unfocus();
                  }
                },
                icon: Icon(Icons.send,
                    color: (controller.text.isNotEmpty)
                        ? Colors.blue
                        : Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
