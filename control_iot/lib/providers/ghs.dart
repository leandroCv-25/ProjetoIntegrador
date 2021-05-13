import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';

import '../models/gh.dart';
import 'user_manager.dart';

class Ghs with ChangeNotifier {
  List<Gh> _ghs = [];
  String? userId = "";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Ghs();

  String _search = '';
  bool _error = false;
  bool _loading = false;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get error => _error;
  set error(bool e) {
    _error = e;
    notifyListeners();
  }

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Gh> get filteredGhs {
    final List<Gh> filteredGhs = [];

    if (search.isEmpty) {
      filteredGhs.addAll(_ghs);
    } else {
      filteredGhs.addAll(_ghs.where(
          (gh) => gh.ghName!.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredGhs;
  }

  void updateUser(UserManager userManager) {
    if (userManager.isLoggedIn) {
      userId = userManager.userUid;
    } else {
      userId = "";
    }
    _loadAllGhs();
  }

  Gh findById(String id) {
    return _ghs.firstWhere((prod) => prod.id == id);
  }

  Future<void> _loadAllGhs() async {
    if (userId != "") {
      try {
        error = false;
        loading = true;

        firestore
            .collection('Ghs')
            .where('owner', isEqualTo: userId)
            .snapshots()
            .listen((snapshot) {
          _ghs.clear();
          _ghs = snapshot.docs.map((d) => Gh.fromDocument(d)).toList();
        });
        error = false;
        loading = false;
      } catch (erro) {
        debugPrint(erro.toString());
        error = true;
        loading = false;
      }
    } else {
      _ghs = [];
    }
  }

  Future<void> newGh(String text) async {
    loading = true;
    error = false;

    try {
      final response = await FirebaseFunctions.instance
          .httpsCallable('setUser')
          .call({"estufa": text.trim()});

      debugPrint("aqui");

      if (response.data["test"] != null && response.data["test"] as bool) {
        _loadAllGhs();
      } else {
        loading = false;
        error = true;
        debugPrint("Erro dados");
      }
    } catch (e) {
      loading = false;
      error = true;
      debugPrint(e.toString());
    }
  }
}
