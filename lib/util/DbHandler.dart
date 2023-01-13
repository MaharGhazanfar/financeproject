import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financeproject/util/const_value.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DbHandler {
  static User? user = FirebaseAuth.instance.currentUser;
  static String userUid = user!.uid.toString();

  static CollectionReference adminCollection() {
    return FirebaseFirestore.instance.collection(ConstValue.admin);
  }

  static CollectionReference customerCollection() {
    return FirebaseFirestore.instance
        .collection(ConstValue.admin)
        .doc(userUid)
        .collection(ConstValue.customer);
  }

  static CollectionReference EmployeeCollection() {
    return FirebaseFirestore.instance
        .collection(ConstValue.admin)
        .doc(userUid)
        .collection(ConstValue.employeeCollectionName);
  }

  // static CollectionReference EmployeeCollectionWithUid(String adminUid) {
  //   return FirebaseFirestore.instance
  //       .collection(ConstValue.admin)
  //       .doc(adminUid)
  //       .collection(ConstValue.employeeCollectionName);
  // }
}

Future<String> SignUpWithEmailPas(
    {required String email, required String password}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return 'Login Successful';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    print(e);
    return 'SomeThing went wrong';
  }
  return 'Please try again later';
}

Future<String> signInWithEmail(
    {required String password, required String email}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return 'Login Successful';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user';
    }
  }
  return 'SomeThing Went Wrong';
}

Future<String> uploadImage(File imageFile) async {
  var firebaseStorageRef = FirebaseStorage.instance.ref();
  var random = Random();

  var upload = firebaseStorageRef
      .child('CustomerPhotos/${random.nextInt(900000) + 100000}');

  await upload.putFile(imageFile);

  return upload.getDownloadURL();
}

ShowCustomToast({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
