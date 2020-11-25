import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkup/app/Pages/conversa.dart';
import 'package:linkup/app/Pages/conversas.dart';
import 'package:linkup/app/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _controller;
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
              })
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
                      margin: EdgeInsets.only(left: 0, right: 0, bottom: 10),
                      child: Container(
                        color: Theme.of(context).accentColor,
                        child: Column(
                          children: [
                            Container(
                              child: Image.network(
                                "https://i.pinimg.com/originals/2c/2b/00/2c2b004b23c30d21d62a7f4216fead3e.jpg",
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                              width: double.infinity,
                              height: alturaTela * 0.22,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 8, right: 8),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  snapshot.data[index].nome,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 8, right: 8, bottom: 10),
                              child: Container(
                                child: Text(
                                    "Huheuehue ehuehuhu eheuheueh ehueheuhe heuheuheue ehu eheuheuhu eh ueh euhe uheheuheuehueheu ehueheu"),
                                width: double.infinity,
                              ),
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
