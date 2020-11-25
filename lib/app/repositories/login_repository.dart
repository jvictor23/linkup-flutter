import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkup/app/Interfaces/login_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository implements ILoginRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<bool> login(String email, String senha) async {
    final preferences = await SharedPreferences.getInstance();
    //auth.signOut();
    var response =
        await auth.signInWithEmailAndPassword(email: email, password: senha);

    var snap =
        await firestore.collection("Usuario").doc(response.user.uid).get();
    preferences.setString("nome", snap.data()["nome"]);
    preferences.setString("id", snap.data()["id"]);
    preferences.setString("tipo", snap.data()["tipo"]);

    return true;
  }
}
