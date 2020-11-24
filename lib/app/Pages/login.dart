import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:linkup/app/Pages/cadastro.dart';
import 'package:linkup/app/Pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: Center(
                        child: Text(
                          "LinkUP",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 100,
                              color: Theme.of(context).accentColor),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          hintText: "Email",
                          fillColor: Theme.of(context).accentColor,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: Theme.of(context).primaryColor,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(25))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      cursorColor: Theme.of(context).primaryColor,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          hintText: "Senha",
                          fillColor: Theme.of(context).accentColor,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(25))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Text("Entrar"),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => CadastroPage()));
                      },
                      child: Text(
                        "Não possiu cadastro? Crie agora",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                  /*Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Text(
                      "Ou",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  SignInButton(
                    Buttons.Google,
                    onPressed: () {},
                    text: "Entrar com o Google",
                  ),
                  SignInButton(
                    Buttons.FacebookNew,
                    onPressed: () {},
                    text: "Entrar com o Facebook",
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}