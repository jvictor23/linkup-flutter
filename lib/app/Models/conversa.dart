import 'package:cloud_firestore/cloud_firestore.dart';

class Conversa {
  String idRemetente;
  String idDestinatario;
  String nome;
  String mensagem;

  Conversa();

  salvar() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("Conversas")
        .doc(this.idRemetente)
        .collection("ultima-conversa")
        .doc(this.idDestinatario)
        .set(this.toMap());
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idRemetente": this.idRemetente,
      "idDestinatario": this.idDestinatario,
      "nome": this.nome,
      "mensagem": this.mensagem
    };

    return map;
  }
}
