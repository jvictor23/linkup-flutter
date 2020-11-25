import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkup/app/Models/conversa.dart';
import 'package:linkup/app/Models/mensagem.dart';
import 'package:linkup/app/Models/usuario.dart';
import 'package:linkup/app/controllers/conversa_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversaPage extends StatefulWidget {
  @override
  _ConversaPageState createState() => _ConversaPageState();
  Usuario usuario;
  ConversaPage(this.usuario);
}

class _ConversaPageState extends State<ConversaPage> {
  TextEditingController _controllerMenssagem = TextEditingController();
  ConversaController _controller;
  SharedPreferences preferences;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _initialize();
    _controller = ConversaController();
  }

  _initialize() async {
    preferences = await SharedPreferences.getInstance();
  }

  _enviarMensagem() {
    if (_controllerMenssagem.text.isNotEmpty) {
      Mensagem mensagem = Mensagem();
      mensagem.mensagem = _controllerMenssagem.text;
      mensagem.idUsuarioDestinatario = widget.usuario.id;
      _controllerMenssagem.clear();

      _controller.enviaMenssagem(mensagem);

      Conversa cRemetente = Conversa();
      cRemetente.idRemetente = auth.currentUser.uid;
      cRemetente.idDestinatario = widget.usuario.id;
      cRemetente.nome = widget.usuario.nome;
      cRemetente.mensagem = mensagem.mensagem;
      cRemetente.salvar();
      // _controller.salvarConversa(cRemetente);

      Conversa cDestinatario = Conversa();
      cDestinatario.idRemetente = widget.usuario.id;
      cDestinatario.idDestinatario = auth.currentUser.uid;
      cDestinatario.nome = widget.usuario.nome;
      cDestinatario.mensagem = mensagem.mensagem;
      cDestinatario.salvar();
      // _controller.salvarConversa(cDestinatario);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nome"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _controller.getMensagens(widget.usuario.id),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    default:
                  }
                  QuerySnapshot querySnapshot = snapshot.data;
                  return Expanded(
                      child: ListView.builder(
                          itemCount: querySnapshot.docs.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: querySnapshot.docs[index]
                                          ["idUsuario"] ==
                                      preferences.getString("id")
                                  ? Alignment.centerRight
                                  : Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Text(
                                    querySnapshot.docs[index]["mensagem"],
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            );
                          }));
                }),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              padding: EdgeInsets.only(left: 5),
              child: TextField(
                controller: _controllerMenssagem,
                decoration: InputDecoration(
                    fillColor: Theme.of(context).accentColor,
                    filled: true,
                    suffixIcon: IconButton(
                        icon: Icon(Icons.send), onPressed: _enviarMensagem)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
