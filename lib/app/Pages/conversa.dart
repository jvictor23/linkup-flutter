import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initialize();
    _controller = ConversaController();
  }

  _initialize() async {
    preferences = await SharedPreferences.getInstance();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  _enviarMensagem() {
    if (_controllerMenssagem.text.isNotEmpty) {
      Mensagem mensagem = Mensagem();
      mensagem.mensagem = _controllerMenssagem.text;
      mensagem.idUsuarioDestinatario = widget.usuario.id;
      mensagem.tokenDestinatario = widget.usuario.tokenNotification;
      _controllerMenssagem.clear();

      _controller.enviaMenssagem(mensagem);
      Timer(Duration(milliseconds: 500), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });

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
      cDestinatario.nome = preferences.getString("nome");
      cDestinatario.mensagem = mensagem.mensagem;
      cDestinatario.salvar();
      // _controller.salvarConversa(cDestinatario);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.usuario.nome),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _controller.getMensagens(widget.usuario.id).stream,
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
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                  });
                  return Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
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
                                  child: Column(
                                    crossAxisAlignment: querySnapshot
                                                .docs[index]["idUsuario"] ==
                                            preferences.getString("id")
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        querySnapshot.docs[index]
                                                    ["idUsuario"] ==
                                                preferences.getString("id")
                                            ? "Eu"
                                            : widget.usuario.nome,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        querySnapshot.docs[index]["mensagem"],
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }));
                }),
            Container(
              child: TextField(
                controller: _controllerMenssagem,
                decoration: InputDecoration(
                    fillColor: Theme.of(context).accentColor,
                    hintText: "Digite uma mensagem",
                    hintStyle: TextStyle(fontSize: 13),
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
