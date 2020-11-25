import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkup/app/Models/conversa.dart';
import 'package:linkup/app/Models/mensagem.dart';

abstract class IConversaRepository {
  Future<bool> enviaMenssagem(Mensagem mensagem);
  Stream<QuerySnapshot> listaMensagem(String idUsuarioDestinatario);
  Future<bool> salvarConversa(Conversa conversa);
  StreamController<QuerySnapshot> listaConversas();
}
