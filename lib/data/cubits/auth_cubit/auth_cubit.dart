import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_project/utils/my_utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.fireAuth}) : super(AuthState());

  final FirebaseAuth fireAuth;

  Future<void> signUp({required String email, required String password, required BuildContext context}) async {
    try {
      await fireAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      MyUtils.getMyToast(message: e.message.toString());
    }
  }

  Future<void> signIn({required String email, required String password, required BuildContext context}) async {
    try {
      await fireAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      MyUtils.getMyToast(message: e.message.toString());
    }
  }

  void signOut(BuildContext context) async {
    try {
      await fireAuth.signOut();
    } on FirebaseAuthException catch (e) {
      MyUtils.getMyToast(message: e.message.toString());
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await fireAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      MyUtils.getMyToast(message: e.message.toString());
    }
  }

  User get user => fireAuth.currentUser!;

  Stream<User?> authState() async* {
    yield* FirebaseAuth.instance.authStateChanges();
  }
}
