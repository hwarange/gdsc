
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/home/view/home_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../login/login_view.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => LoginView());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }



  void register(String email, password, name, nickname, int age) async {
    try {
      UserCredential userCredential = await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
      await usersCollection.doc(userCredential.user?.uid).set({
        'email': email,
        'uid': userCredential.user?.uid, // UID 저장
        'name': name,
        'nickname' : nickname,
        'age': age,

        // 다른 사용자 정보도 추가할 수 있음
      });
    } catch (e) {
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Registration is failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }




  void googleregister(String email, String name, String nickname, int age) async {
    try {
      // Google 로그인 사용자의 UserCredential 객체 가져오기
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Firestore에 사용자 정보 저장
      await usersCollection.doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid,
        'name': name,
        'nickname': nickname,
        'age': age,
        // 다른 사용자 정보도 추가할 수 있음
      });
    } catch (e) {
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Registration is failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }


  void login(String email, password) async {
    try {
      await authentication.signInWithEmailAndPassword(
          email: email, password: password);
    }catch(e){
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "로그인 실패~",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }


  void logout(){
    authentication.signOut();
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

final firestore = FirebaseFirestore.instance;
Future<bool> isEmailRegisteredInFirestore(String userEmail) async {
  final query = await firestore.collection('users').where('email', isEqualTo: userEmail).get();
  return query.docs.isNotEmpty;
}
  
