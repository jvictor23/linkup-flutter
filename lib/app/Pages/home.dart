import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkup/app/Pages/conversa.dart';
import 'package:linkup/app/Pages/conversas.dart';
import 'package:linkup/app/Pages/login.dart';
import 'package:linkup/app/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _controller;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    double larguraTela = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.messenger_outline_sharp),
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => ConversasPage()));
              }),
          PopupMenuButton(
              onSelected: (a) async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.clear();
                auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Sair"),
                      value: "Sair",
                    )
                  ])
        ],
      ),
      body: FutureBuilder(
          future: _controller.getPerfis(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.none:
                break;
              default:
            }

            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ConversaPage(snapshot.data[index])));
                    },
                    child: Card(
                      margin: EdgeInsets.only(left: 0, right: 0, bottom: 2),
                      child: Container(
                        color: Theme.of(context).accentColor,
                        height: alturaTela * 0.2,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: snapshot.data[index].tipo == "investidor"
                                    ? Image.network(
                                        "https://images.vexels.com/media/users/3/128092/isolated/preview/b93c119029c78b0106e34486e9c70f26---cone-de-m--o-desenhada-de-ideia-by-vexels.png",
                                        alignment: Alignment.topCenter,
                                      )
                                    : Image.network(
                                        "https://abstartups.com.br/wp-content/uploads/2016/12/45437-saiba-qual-e-o-melhor-tipo-de-investidor-para-sua-startup.jpg",
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      ),
                                height: alturaTela * 0.14,
                                width: larguraTela * 0.3,
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      snapshot.data[index].nome,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              width: larguraTela * 0.65,
                              height: alturaTela * 0.13,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
