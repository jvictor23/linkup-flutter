import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkup/app/Interfaces/home_interface.dart';
import 'package:linkup/app/Models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository implements IHomeRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<Post>> getPerfis() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.getString("tipo") == "investidor") {
      var response = await firestore
          .collection("Usuario")
          .where("tipo", isEqualTo: "startup")
          .get();
      List<Post> listPosts = List();
      for (var p in response.docs) {
        Post post = Post();
        post.id = p.data()["id"];
        post.nome = p.data()["nome"];
        listPosts.add(post);
      }
      return listPosts;
    } else {
      var response = await firestore
          .collection("Usuario")
          .where("tipo", isEqualTo: "investidor")
          .get();
      List<Post> listPosts = List();
      for (var p in response.docs) {
        Post post = Post();
        post.id = p.data()["id"];
        post.nome = p.data()["nome"];
        listPosts.add(post);
      }
      return listPosts;
    }
  }
}
