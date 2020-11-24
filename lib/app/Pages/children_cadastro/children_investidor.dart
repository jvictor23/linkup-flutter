import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linkup/app/Models/investidor.dart';
import 'package:linkup/app/controllers/cadastrar_controller.dart';

class ChildrenInvestidor extends StatefulWidget {
  @override
  _ChildrenInvestidorState createState() => _ChildrenInvestidorState();
}

class _ChildrenInvestidorState extends State<ChildrenInvestidor> {
  CadastrarController _controller = CadastrarController();

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = CadastrarController();
  }

  _cadastrar() async {
    if (_controllerNome.text.isNotEmpty) {
      if (_controllerTelefone.text.isNotEmpty) {
        if (_controllerEmail.text.isNotEmpty) {
          if (_controllerSenha.text.isNotEmpty) {
            Investidor investidor = Investidor();
            investidor.nome = _controllerNome.text;
            investidor.telefone = _controllerTelefone.text;
            investidor.email = _controllerEmail.text;
            investidor.senha = _controllerSenha.text;
            bool create = await _controller.cadastrarInvestidor(investidor);
            if (create) {
              Navigator.pop(context);
            }
          } else {
            Fluttertoast.showToast(
                msg: "O campo senha não pode ficar vazio!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          Fluttertoast.showToast(
              msg: "O campo email não pode ficar vazio!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "O telefone nome não pode ficar vazio!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "O campo nome não pode ficar vazio!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextField(
                    controller: _controllerNome,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        hintStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        hintText: "Nome",
                        fillColor: Theme.of(context).accentColor,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(25))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextField(
                    controller: _controllerTelefone,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        hintStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        hintText: "Telefone",
                        fillColor: Theme.of(context).accentColor,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(25))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextField(
                    controller: _controllerEmail,
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
                    controller: _controllerSenha,
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
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _cadastrar,
                  child: Text("Cadastrar Investidor"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
