import 'package:flutter/material.dart';

class ConversaPage extends StatefulWidget {
  @override
  _ConversaPageState createState() => _ConversaPageState();
}

class _ConversaPageState extends State<ConversaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nome"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              "KK erhjasdfhdjkfhjkasdfk",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      );
                    })),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              padding: EdgeInsets.only(left: 5),
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Theme.of(context).accentColor,
                    filled: true,
                    suffixIcon:
                        IconButton(icon: Icon(Icons.send), onPressed: () {})),
              ),
            )
          ],
        ),
      ),
    );
  }
}
