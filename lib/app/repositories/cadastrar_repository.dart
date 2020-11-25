import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkup/app/Interfaces/cadastrar_interface.dart';
import 'package:linkup/app/Models/startup.dart';
import 'package:linkup/app/Models/investidor.dart';

class CadastrarRepository implements ICadastrarRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<bool> cadastrarInvestidor(Investidor investidor) async {
    auth
        .createUserWithEmailAndPassword(
            email: investidor.email, password: investidor.senha)
        .then((value) async {
      investidor.id = value.user.uid;
      investidor.tipo = "investidor";
      await firestore
          .collection("Usuario")
          .doc(investidor.id)
          .set(investidor.toMap());
    });
    return true;
  }

  @override
  Future<bool> cadastrarStartup(StarTup starTup) async {
    auth
        .createUserWithEmailAndPassword(
            email: starTup.email, password: starTup.senha)
        .then((value) async {
      starTup.id = value.user.uid;
      starTup.tipo = "startup";
      await firestore
          .collection("Usuario")
          .doc(starTup.id)
          .set(starTup.toMap());
    });
    return true;
  }
}
