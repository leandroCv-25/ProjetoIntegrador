import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../helpers/firebase_erros.dart';
import '../models/user.dart' as model;

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  model.User? user;
  bool get isLoggedIn => user != null;

  bool _loading = false;
  bool get loading => _loading;

  UserManager() {
    _loadCurrentUser();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signUp(
      {required model.User user,
      Function? onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

      user.id = result.user!.uid;
      this.user = user;

      await user.saveData();
      onSuccess();
    } on PlatformException catch (e) {
      //debugPrint(e.message);
      onFail!(getErrorString(e.code));
    } catch (error) {
      debugPrint(error.toString());
      onFail!(getErrorString(error.toString()));
    }
    loading = false;
  }

  Future<void> signIn(model.User user,
      {Function? onFail, required Function onSuccess}) async {
    loading = true;
    try {
      //debugPrint(user.email);
      final result = await auth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    } on PlatformException catch (e) {
      //debugPrint(e.message);
      onFail!(getErrorString(e.code));
    } catch (error) {
      debugPrint(error.toString());
      onFail!(getErrorString(error.toString()));
    }
    loading = false;
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    if (firebaseUser != null) {
      final User currentUser = firebaseUser;
      final DocumentSnapshot<Map<String, dynamic>> docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      user = model.User.fromDocument(docUser);

      final docAdmin = await firestore.collection('admin').doc(user!.id).get();
      if (docAdmin.exists) {
        user!.admin = true;
      }

      notifyListeners();
    } else {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        final DocumentSnapshot<Map<String, dynamic>> docUser =
            await firestore.collection('users').doc(currentUser.uid).get();
        user = model.User.fromDocument(docUser);

        final docAdmin =
            await firestore.collection('admin').doc(user!.id).get();
        if (docAdmin.exists) {
          user!.admin = true;
        }

        notifyListeners();
      }
    }
  }

  bool get adminEnabled => user != null && user!.admin;

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  String? get userUid {
    if (isLoggedIn) {
      return user!.id;
    } else {
      return null;
    }
  }
}
