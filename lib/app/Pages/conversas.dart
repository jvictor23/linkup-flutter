import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linkup/app/Models/usuario.dart';
import 'package:linkup/app/Pages/conversa.dart';
import 'package:linkup/app/controllers/conversa_controller.dart';

class ConversasPage extends StatefulWidget {
  @override
  _ConversasPageState createState() => _ConversasPageState();
}

class _ConversasPageState extends State<ConversasPage> {
  ConversaController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ConversaController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: _controller.listaConversas().stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  default:
                }

                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Usuario usuario = Usuario();
                            usuario.nome =
                                snapshot.data.docs[index].data()["nome"];
                            usuario.id = snapshot.data.docs[index]
                                .data()["idDestinatario"];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ConversaPage(usuario)));
                          },
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 26,
                          ),
                          title: Text(snapshot.data.docs[index].data()["nome"]),
                          subtitle: Text(
                              snapshot.data.docs[index].data()["mensagem"]),
                          trailing: Text("16:35"),
                        ),
                      );
                    });
              }),
        ));
  }
}
