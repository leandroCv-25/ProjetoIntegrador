//models
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Gh extends ChangeNotifier {
  String? id;
  String? ghName;
  num? temperature;
  num? humidity;
  num? lightInitHour;
  num? lightInitMinute;
  num? lightEndHour;
  num? lightEndMinute;
  bool? light;
  bool? lightSwitch;
  num? previsionWater;
  num? tank;
  String? model;
  String? owner;
  num? k;
  num? brightness;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference get ghRef => firestore.collection('Ghs').doc(id);

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _error = false;
  bool get error => _error;
  set error(bool value) {
    _error = value;
    notifyListeners();
  }

  Gh.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    id = document.id;
    model = document.data()!['model'] as String?;
    ghName = document.data()!['ghName'] as String? ?? model;
    owner = document.data()!['owner'] as String?;
    previsionWater = document.data()!['previsionWater'] as num?;
    lightInitHour = document.data()!['lightInitHour'] as num?;
    lightInitMinute = document.data()!['lightInitMinute'] as num?;
    lightEndHour = document.data()!['lightEndHour'] as num?;
    lightEndMinute = document.data()!['lightEndMinute'] as num?;
    lightSwitch = document.data()!['lightSwitch'] as bool?;
    temperature = document.data()!['temperature'] as num?;
    humidity = document.data()!['humidity'] as num?;
    tank = document.data()!['tank'] as num?;
    light = document.data()!['light'] as bool?;
    k = document.data()!['k'] as num?;
    brightness = document.data()!['brightness'] as num?;
  }

  Future<void> changeName(String newName) async {
    try {
      loading = true;
      error = false;
      if (newName.isNotEmpty) {
        await ghRef.set({"ghName": newName}, SetOptions(merge: true));
        ghName = newName;
      }
    } catch (e) {
      error = true;
      debugPrint(e.toString());
    } finally {
      loading = false;
    }
  }

  Future<void> ghSwitch({bool? value}) async {
    try {
      loading = true;
      error = false;
      if (value != null) {
        await ghRef.set({"lightSwitch": value}, SetOptions(merge: true));
        lightSwitch = value;
      }
    } catch (e) {
      error = true;
      debugPrint(e.toString());
    } finally {
      loading = false;
    }
  }

  Future<void> timer({num? hour, num? minute, bool isEnd = false}) async {
    try {
      loading = true;
      error = false;
      if (hour != null && minute != null) {
        if (isEnd) {
          await ghRef.set({"lightEndHour": hour, "lightEndMinute": minute},
              SetOptions(merge: true));
          lightEndHour = hour;
          lightEndMinute = minute;
        } else {
          await ghRef.set({"lightInitHour": hour, "lightInitMinute": minute},
              SetOptions(merge: true));
          lightInitHour = hour;
          lightInitMinute = minute;
        }
      }
    } catch (e) {
      error = true;
      debugPrint(e.toString());
    } finally {
      loading = false;
    }
  }

  Future<void> plant({String? theVaseId, required DateTime date}) async {
    try {} catch (e) {
      error = true;
      debugPrint(e.toString());
    } finally {
      loading = false;
    }
  }
}
