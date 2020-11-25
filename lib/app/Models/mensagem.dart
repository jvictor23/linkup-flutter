import 'package:cloud_firestore/cloud_firestore.dart';

class Mensagem {
  String idUsuario;
  String idUsuarioDestinatario;
  String mensagem;
  int data = Timestamp.now().seconds;
  String tokenDestinatario;

  Mensagem();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": this.idUsuario,
      "mensagem": this.mensagem,
      "data": this.data
    };

    return map;
  }
}
