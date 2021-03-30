import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/presentation/signUp/sign_up_page.dart';
import 'package:training_app/signIn/sign_in_model.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ログイン'),
        ),
        body: Consumer<SignInModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'example@example.com',
                    ),
                    obscureText: false,
                    controller: mailController,
                    onChanged: (text) {
                      model.mail = text;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'パスワード',
                    ),
                    obscureText: true,
                    controller: passwordController,
                    onChanged: (text) {
                      model.password = text;
                    },
                  ),
                  ElevatedButton(
                    child: Text('ログインする'),
                    onPressed: () async {
                      model.signInWithEmail(context);
                    },
                  ),
                  ElevatedButton(
                    child: Text('新規登録'),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Text('sign in with Google account'),
                    onPressed: () async {
                      model.signInWithGoogle();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
