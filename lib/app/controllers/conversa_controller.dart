import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkup/app/Models/conversa.dart';
import 'package:linkup/app/Models/mensagem.dart';
import 'package:linkup/app/repositories/conversa_repository.dart';

class ConversaController {
  ConversaRepository _repository;
  ConversaController() {
    _repository = ConversaRepository();
  }

  Future<bool> enviaMenssagem(Mensagem mensagem) {
    return _repository.enviaMenssagem(mensagem);
  }

  StreamController<QuerySnapshot> getMensagens(String idUsuarioDestinatario) {
    return _repository.listaMensagem(idUsuarioDestinatario);
  }

  Future<bool> salvarConversa(Conversa conversa) {
    return _repository.salvarConversa(conversa);
  }

  StreamController<QuerySnapshot> listaConversas() {
    return _repository.listaConversas();
  }
}
