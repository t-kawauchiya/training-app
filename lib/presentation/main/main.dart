import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/presentation/signUp/sign_up_page.dart';

import '../app_page.dart';
import 'main_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  MaterialApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider<SignInModel>(
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
                        try {
                          String uid = await model.loginAndReturnUid();
                          _showDialog(context, 'ログインしました');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppPage(uid)),
                          );
                        } catch (e) {
                          _showDialog(context, e.toString());
                        }
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
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future? _showDialog(
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
