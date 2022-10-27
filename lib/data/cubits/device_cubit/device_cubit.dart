import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_project/data/models/device_model/device_item.dart';
import 'package:task_project/data/models/my_status/my_status.dart';
import 'package:task_project/data/models/user_model/user_item.dart';

part 'device_state.dart';

class UserCubit extends Cubit<DeviceState> {
  UserCubit({required this.fireStore}) : super(
    const DeviceState(
      errorText: '',
      status: MyStatus.PURE,
      devices: [],
    ),
  );

  final FirebaseFirestore fireStore;
  late StreamSubscription _subscription;

  Future<void> addDevice({
    required DeviceItem device,
  }) async {
    try {
      var newUser = await fireStore.collection("devices").add(device.toJson());
      await fireStore.collection("devices").doc(newUser.id).update({"id": newUser.id});
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

  Future<void> getAllDevices() async {
    emit(state.copyWith(status: MyStatus.LOADING));
    _subscription = fireStore.collection('devices').orderBy("created_at").snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => DeviceItem.fromJson(doc.data())).toList())
        .listen((items) {
      emit(state.copyWith(devices: items, status: MyStatus.SUCCESS));
    }, onError: (error) {
      emit(
        state.copyWith(status: MyStatus.ERROR, errorText: error.toString()),
      );
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
