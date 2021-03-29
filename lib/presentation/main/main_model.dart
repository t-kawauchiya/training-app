import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_page.dart';
import 'FirebaseAuthExceptionHandler.dart';

class SignInModel extends ChangeNotifier {
  late BuildContext context;
  String mail = '';
  String password = '';
  String _uid = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAndReturnUid() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    } else if (password.isEmpty) {
      throw ('パスワードを入力してください');
    } else {
      User user = (await _auth.signInWithEmailAndPassword(
        email: mail,
        password: password,
      ))
          .user!;
      return user.uid;
    }
  }

  void login(context) async {
    this.context = context;
    final FirebaseAuthResultStatus result = await signIn(
      email: mail,
      password: password,
    );

    if (result == FirebaseAuthResultStatus.Successful) {
      // ログイン成功時の処理
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AppPage(_uid),
          ));
    } else {
      // ログイン失敗時の処理
      final errorMessage =
          FirebaseAuthExceptionHandler.exceptionMessage(result);

      // エラー情報をユーザーに何かで通知
      _showErrorDialog(context, errorMessage);
    }
  }

  Future<FirebaseAuthResultStatus> signIn(
      {required String email, required String password}) async {
    FirebaseAuthResultStatus result;
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _uid = userCredential.user!.uid;

      if (userCredential.user == null) {
        // ユーザーが取得できなかったとき
        result = FirebaseAuthResultStatus.Undefined;
      } else {
        // ログイン成功時
        result = FirebaseAuthResultStatus.Successful;
      }
    } on FirebaseAuthException catch (error) {
      // エラー時
      result = FirebaseAuthExceptionHandler.handleException(error);
    }
    return result;
  }

  Future? _showErrorDialog(
    BuildContext context,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
