import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkup/app/Interfaces/conversa_interface.dart';
import 'package:linkup/app/Models/conversa.dart';
import 'package:linkup/app/Models/mensagem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConversaRepository implements IConversaRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<bool> enviaMenssagem(Mensagem mensagem) async {
    final preferences = await SharedPreferences.getInstance();
    mensagem.idUsuario = preferences.getString("id");

    await firestore
        .collection("Mensagens")
        .doc(mensagem.idUsuario)
        .collection(mensagem.idUsuarioDestinatario)
        .add(mensagem.toMap());

    await firestore
        .collection("Mensagens")
        .doc(mensagem.idUsuarioDestinatario)
        .collection(mensagem.idUsuario)
        .add(mensagem.toMap());

    var response = await firestore
        .collection("Usuario")
        .doc(mensagem.idUsuarioDestinatario)
        .get();

    await http.post("https://fcm.googleapis.com/fcm/send",
        body: jsonEncode({
          "notification": {
            "body": "${mensagem.mensagem}",
            "title": "${preferences.getString("nome")}"
          },
          "priority": "high",
          "to": "${response.data()["tokenNotification"]}"
        }),
        headers: {
          "Authorization":
              "key=AAAA2iffHxg:APA91bHrmRaVG6Gt75D-wF-YkRBCx2rWbrSQ8qplA-P8XgytKw55mZITVugwltwrkdSdFr66jEXMOdNlQwJDcjmmpjBVHqlV2CNm__rNFn9zrXfwE1wsE3Eje3m3YOtxy8x4HKAFfuSe",
          "Content-Type": "application/json"
        });

    return true;
  }

  @override
  StreamController<QuerySnapshot> listaMensagem(String idUsuarioDestinatario) {
    final controller = StreamController<QuerySnapshot>.broadcast();
    var response = firestore
        .collection("Mensagens")
        .doc(auth.currentUser.uid)
        .collection(idUsuarioDestinatario)
        .orderBy("data")
        .snapshots();

    response.listen((event) {
      controller.add(event);
    });

    return controller;
  }

  @override
  Future<bool> salvarConversa(Conversa conversa) async {
    final preferences = await SharedPreferences.getInstance();

    conversa.idRemetente = preferences.getString("id");
    if (conversa.idDestinatario == preferences.getString("id")) {
      await firestore
          .collection("Conversas")
          .doc(conversa.idDestinatario)
          .collection("ultima_conversa")
          .doc(conversa.idRemetente)
          .set(conversa.toMap());
    } else {
      await firestore
          .collection("Conversas")
          .doc(conversa.idRemetente)
          .collection("ultima_conversa")
          .doc(conversa.idDestinatario)
          .set(conversa.toMap());
    }

    return true;
  }

  @override
  StreamController<QuerySnapshot> listaConversas() {
    // ignore: close_sinks
    final controller = StreamController<QuerySnapshot>.broadcast();
    final stream = firestore
        .collection("Conversas")
        .doc(auth.currentUser.uid)
        .collection("ultima-conversa")
        .snapshots();

    stream.listen((event) {
      controller.add(event);
    });

    return controller;
  }
}
