import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkup/app/Interfaces/cadastrar_interface.dart';
import 'package:linkup/app/Models/usuario.dart';

class CadastrarRepository implements ICadastrarRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<bool> cadastrarInvestidor(Usuario usuario) async {
    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((value) async {
      usuario.id = value.user.uid;
      usuario.tipo = "investidor";
      await firestore
          .collection("Usuario")
          .doc(usuario.id)
          .set(usuario.toMap());
    });
    return true;
  }

  @override
  Future<bool> cadastrarStartup(Usuario usuario) async {
    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((value) async {
      usuario.id = value.user.uid;
      usuario.tipo = "startup";
      await firestore
          .collection("Usuario")
          .doc(usuario.id)
          .set(usuario.toMap());
    });
    return true;
  }
}
