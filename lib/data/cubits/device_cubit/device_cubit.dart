import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_project/data/api/device_info.dart';
import 'package:task_project/data/models/device_model/device_item.dart';
import 'package:task_project/data/models/my_status/my_status.dart';

part 'device_state.dart';

class DeviceCubit extends Cubit<DeviceState> {
  DeviceCubit({required this.fireStore})
      : super(
          const DeviceState(
            errorText: '',
            status: MyStatus.PURE,
            devices: [],
          ),
        );

  final FirebaseFirestore fireStore;
  late StreamSubscription _subscription;
  bool has = false;

  Future<void> addDevice({
    required DeviceItem device,
  }) async {
    try {
      var newUser = await fireStore.collection("devices").add(device.toJson());
      await fireStore
          .collection("devices")
          .doc(newUser.id)
          .update({"id": newUser.id});
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> deleteDevice({required String docId}) async {
    try {
      await fireStore.collection("devices").doc(docId).delete();
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
  }

  Stream<List<DeviceItem>> getUserStreamDevices({required String uid}) =>
      fireStore
          .collection('devices')
          .where("uid", isEqualTo: uid)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs.map((doc) => DeviceItem.fromJson(doc.data())).toList(),
          );

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
