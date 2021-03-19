import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future loginAndReturnUid() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    }

    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }

    User user = (await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    ))
        .user!;
    return user.uid;
  }
}
