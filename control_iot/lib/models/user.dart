import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User {
  User({this.email, this.password, this.name, this.id});

  User.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    id = document.id;
    name = document.data()!['name'] as String?;
    email = document.data()!['email'] as String?;
  }

  String? id;
  String? name;
  String? email;
  String? password;

  String? confirmPassword;

  bool admin = false;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async {
    debugPrint(toMap().toString());
    await FirebaseFirestore.instance.doc('users/$id').set(toMap());
  }

  CollectionReference<Map<String, dynamic>> get cartReference =>
      firestoreRef.collection('cart');

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
