import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/data/cubits/device_cubit/device_cubit.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<User?>();
    if (user == null){
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Devices"), centerTitle: true),
      body: StreamBuilder(
        stream: BlocProvider.of<DeviceCubit>(context).getUserStreamDevices(uid: user!.uid),
        builder: (context, state) {
          if (state.hasData) {
            var devices = state.data;
            return devices!.isNotEmpty ? ListView(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              children: List.generate(devices.length, (index) {
                var device = devices[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(device.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                      IconButton(
                        onPressed: () {
                          context.read<DeviceCubit>().deleteDevice(docId: device.id);
                        },
                        icon: const Icon(Icons.cancel, color: Colors.red),
                      ),
                    ],
                  ),
                );
              }),
            )
                : const Center(child: Text("List Empty"));
          }
          else if (state.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if (state.hasError){
            return const Center(child: Text("ERROR"));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
