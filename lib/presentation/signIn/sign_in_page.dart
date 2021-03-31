import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:training_app/presentation/signIn/sign_in_model.dart';
import 'package:training_app/presentation/signUp/sign_up_page.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<SignInModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('images/machoman.jpeg'))),
                  ),
                  Text(
                    'Let`s training',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      color: Colors.amber,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 300,
                      child: Column(
                        children: [
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
                          SizedBox(
                            width: double.infinity,
                            child: SignInButtonBuilder(
                              text: 'Sign in with Email',
                              textColor: Colors.black87,
                              icon: Icons.email,
                              backgroundColor: Colors.amber,
                              onPressed: () async {
                                model.signInWithEmail(context);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: SignInButton(
                              Buttons.Google,
                              onPressed: () async {
                                model.signInWithGoogle();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  child: Text('create account'),
                                  style: TextButton.styleFrom(
                                    primary: Colors.amber,
                                  ),
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpPage()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
