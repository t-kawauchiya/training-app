import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:training_app/presentation/main/FirebaseAuthExceptionHandler.dart';

class SignInModel extends ChangeNotifier {
  late BuildContext context;
  String mail = '';
  String password = '';

  static final googleLogin = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  void signInWithGoogle() async {
    GoogleSignInAccount signInAccount = (await googleLogin.signIn())!;
    GoogleSignInAuthentication auth = await signInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );
    FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signInWithEmail(context) async {
    this.context = context;
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    } else if (password.isEmpty) {
      throw ('パスワードを入力してください');
    } else {
      final FirebaseAuthResultStatus result = await _signInWithEmailLogic(
        email: mail,
        password: password,
      );

      if (result == FirebaseAuthResultStatus.Successful) {
        // ログイン成功時の処理なし
      } else {
        // ログイン失敗時の処理
        final errorMessage =
            FirebaseAuthExceptionHandler.exceptionMessage(result);

        // エラー情報をユーザーに何かで通知
        _showErrorDialog(context, errorMessage);
      }
    }
  }

  Future<FirebaseAuthResultStatus> _signInWithEmailLogic(
      {required String email, required String password}) async {
    FirebaseAuthResultStatus result;
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

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
