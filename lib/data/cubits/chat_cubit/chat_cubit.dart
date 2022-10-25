import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_project/data/models/message_item.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.fireStore}) : super(ChatInitial());

  final FirebaseFirestore fireStore;

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
  //
  // Stream<List<MessageItem>> getMessages() =>
  //     _fireStore.collection('messages').orderBy("created_at").snapshots().map(
  //           (snapshot) => snapshot.docs
  //           .map((doc) => MessageItem.fromJson(doc.data()))
  //           .toList(),
  //     );
}
