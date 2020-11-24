import 'package:flutter/material.dart';
import 'package:linkup/app/Pages/conversa.dart';

class ConversasPage extends StatefulWidget {
  @override
  _ConversasPageState createState() => _ConversasPageState();
}

class _ConversasPageState extends State<ConversasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConversaPage()));
                  },
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 26,
                  ),
                  title: Text("Nome"),
                  subtitle: Text("Pedaço da ultima conversa"),
                  trailing: Text("16:35"),
                ),
              );
            }),
      ),
    );
  }
}
