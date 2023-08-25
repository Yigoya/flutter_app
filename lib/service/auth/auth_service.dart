import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential> signUpWithEmailandPassword(String email,
      String password, String name, String phone, String account) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'phone': phone,
        'account': account,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> post(String title, String description, String place,
      String price, String catagory, String url) async {
    final Timestamp timestamp = Timestamp.now();
    final String id = _firebaseAuth.currentUser!.uid;
    print(catagory);
    await _fireStore.collection('posts').doc(catagory).collection('post').add({
      'title': title,
      'description': description,
      'place': place,
      'money': price,
      'catagory': catagory,
      'ImageUrl': url,
      'timestamp': timestamp,
      'userid': _firebaseAuth.currentUser!.uid
    });
  }
}
