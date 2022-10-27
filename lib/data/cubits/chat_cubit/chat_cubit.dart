import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_project/data/models/message_model/message_item.dart';
import 'package:task_project/data/models/my_status/my_status.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.fireStore})
      : super(
          const ChatState(
            errorText: '',
            messages: [],
            status: MyStatus.PURE,
          ),
        );

  final FirebaseFirestore fireStore;
  late StreamSubscription _subscription;

  Future<void> sendMessage({
    required MessageItem messageItem,
  }) async {
    try {
      var newMessage = await fireStore.collection("messages").add(messageItem.toJson());
      await fireStore.collection("messages").doc(newMessage.id).update({"messageId": newMessage.id});
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> getMessages() async {
    emit(state.copyWith(status: MyStatus.LOADING));
    _subscription = fireStore
        .collection('messages')
        .orderBy("created_at")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageItem.fromJson(doc.data()))
            .toList())
        .listen((items) {
      emit(state.copyWith(messages: items, status: MyStatus.SUCCESS));
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
