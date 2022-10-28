import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_project/data/models/my_status/my_status.dart';
import 'package:task_project/data/models/user_model/user_item.dart';

part 'users_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.fireStore})
      : super(
          const UserState(
            errorText: '',
            status: MyStatus.PURE,
            users: [],
          ),
        );

  final FirebaseFirestore fireStore;
  late StreamSubscription _subscription;

  Future<void> addUser({
    required UserItem user,
  }) async {
    try {
      var newUser = await fireStore.collection("users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> deleteUser({required String docId}) async {
    try {
      await fireStore.collection("users").doc(docId).delete();
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> getAllUsers() async {
    emit(state.copyWith(status: MyStatus.LOADING));
    _subscription = fireStore.collection('users')
        .orderBy("created_at").snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => UserItem.fromJson(doc.data())).toList())
        .listen((items) {
      emit(state.copyWith(users: items, status: MyStatus.SUCCESS));
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
