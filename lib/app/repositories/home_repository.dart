import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkup/app/Interfaces/home_interface.dart';
import 'package:linkup/app/Models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository implements IHomeRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<Usuario>> getPerfis() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.getString("tipo") == "investidor") {
      var response = await firestore
          .collection("Usuario")
          .where("tipo", isEqualTo: "startup")
          .get();
      response.docs.forEach((element) {
        print(element.data());
      });
      List<Usuario> listUsuario = List();
      for (var p in response.docs) {
        Usuario usuario = Usuario();
        usuario.id = p.data()["id"];
        usuario.nome = p.data()["nome"];
        usuario.tokenNotification = p.data()["tokenNotification"];
        listUsuario.add(usuario);
      }
      return listUsuario;
    } else {
      var response = await firestore
          .collection("Usuario")
          .where("tipo", isEqualTo: "investidor")
          .get();

      List<Usuario> listUsuario = List();
      for (var p in response.docs) {
        Usuario usuario = Usuario();
        usuario.id = p.data()["id"];
        usuario.nome = p.data()["nome"];
        usuario.tokenNotification = p.data()["tokenNotification"];
        listUsuario.add(usuario);
      }
      return listUsuario;
    }
  }
}
