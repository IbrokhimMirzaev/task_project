import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_project/data/cubits/users_cubit/users_cubit.dart';
import 'package:task_project/data/models/my_status/my_status.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        centerTitle: true,
      ),
      body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        var st = state.status;

        if (st == MyStatus.LOADING) {
          return const CircularProgressIndicator();
        } else if (st == MyStatus.SUCCESS) {
          var users = state.users;
          return users.isNotEmpty
              ? ListView(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  children: List.generate(users.length, (index) {
                    var user = users[index];
                    return ListTile(
                      onTap: () {},
                      title: Text("ID   ==   ${user.id}"),
                      trailing: Text(user.status.toString()),
                      subtitle: Text(DateFormat.Hm().format(user.createdAt)),
                    );
                  }),
                )
              : const Center(child: Text("List Empty"));
        } else if (st == MyStatus.ERROR) {
          return Center(child: Text(state.errorText));
        }
        return const SizedBox();
      }),
    );
  }
}
