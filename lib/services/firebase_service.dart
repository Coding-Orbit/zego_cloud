import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zego_cloud/firebase_options.dart';
import 'package:zego_cloud/models/user.dart';

class FirebaseService {
  static final _auth = FirebaseAuth.instance;
  static final _store = FirebaseFirestore.instance;

  static UserModel? _currentUser;
  static UserModel get currentUser {
    if (_currentUser == null) {
      throw Exception(
          '_currentUserModel must not be null when calling this getter');
    }
    return _currentUser!;
  }

  static Future<void> setupFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> get buildViews =>
      _store.collection('users').snapshots();

  static Future<bool> signUp({
    required String name,
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final UserModel user = UserModel(
        email: email,
        name: name,
        username: username,
      );

      if (cred.user != null) {
        final docRef = _store.collection('users').doc(cred.user!.uid);
        final doc = await docRef.get();
        if (doc.exists) {
          return false;
        }

        await docRef.set(user.toJson());
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (cred.user != null) {
        final doc = await _store.collection('users').doc(cred.user!.uid).get();
        final data = doc.data();
        if (data != null) {
          _currentUser = UserModel.fromJson(data);
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
