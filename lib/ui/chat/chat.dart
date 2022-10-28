import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_project/data/api/device_info.dart';
import 'package:task_project/data/cubits/auth_cubit/auth_cubit.dart';
import 'package:task_project/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:task_project/data/cubits/device_cubit/device_cubit.dart';
import 'package:task_project/data/cubits/users_cubit/users_cubit.dart';
import 'package:task_project/data/models/device_model/device_item.dart';
import 'package:task_project/data/models/message_model/message_item.dart';
import 'package:task_project/data/models/my_status/my_status.dart';
import 'package:task_project/data/models/user_model/user_item.dart';
import 'package:task_project/ui/chat/widgets/left_side_message_item.dart';
import 'package:task_project/ui/chat/widgets/rightside_message_item.dart';
import 'package:task_project/ui/devices/devices_page.dart';
import 'package:task_project/ui/users/user_page.dart';
import 'package:task_project/utils/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();
  final focusNode = FocusNode();
  String deviceName = '';

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getMessages();
    _init();
    super.initState();
  }

  void _init() async {
    deviceName = await DeviceInfoApi.getPhoneInfo();
    await BlocProvider.of<DeviceCubit>(context).addDevice(
      device: DeviceItem(
        id: '',
        name: deviceName,
        createdAt: DateTime.now(),
        uid: FirebaseAuth.instance.currentUser!.uid,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User?>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Page"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => UsersPage()));
            },
            icon: const Icon(Icons.people),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => DevicesPage()));
            },
            icon: const Icon(Icons.devices),
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
          StreamBuilder(
            stream: BlocProvider.of<DeviceCubit>(context)
                .getUserStreamDevices(uid: user!.uid),
            builder: (context, state) {
              if (state.hasData) {
                var data = state.data!;
                List<String> devices = data.map((e) => e.name).toList();

                print("LENGTH ========== ${devices.length}");

                print("DEVICE NAME ====== $deviceName");

                if (!devices.contains(deviceName)) {
                  BlocProvider.of<AuthCubit>(context).signOut(context);
                }
              }
              return const SizedBox();
            },
          ),
          BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
            var st = state.status;

            if (st == MyStatus.LOADING) {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            } else if (st == MyStatus.SUCCESS) {
              var messages = state.messages;
              return messages.isNotEmpty
                  ? Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        children: List.generate(messages.length, (index) {
                          var message = messages[index];
                          return (message.uid == user!.uid)
                              ? RightSideMessageItem(
                                  dateText:
                                      DateFormat.Hm().format(message.createdAt),
                                  messageText: message.message,
                                )
                              : LeftSideMessageItem(
                                  dateText:
                                      DateFormat.Hm().format(message.createdAt),
                                  messageText: message.message,
                                );
                        }),
                      ),
                    )
                  : const Expanded(child: Center(child: Text("List Empty")));
            } else if (st == MyStatus.ERROR) {
              return Expanded(child: Center(child: Text(state.errorText)));
            }
            return const SizedBox();
          }),
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
                      hintText: "Type something...",
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
                    setState(() {});
                  }
                },
                icon: Icon(
                  Icons.send,
                  color:
                      (controller.text.isNotEmpty) ? Colors.blue : Colors.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
