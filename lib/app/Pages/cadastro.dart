import 'package:flutter/material.dart';
import 'package:linkup/app/Pages/children_cadastro/children_investidor.dart';
import 'package:linkup/app/Pages/children_cadastro/children_startup.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  int _index = 0;
  var listaChidrenCadastro = [ChildrenInvestidor(), ChildrenStartup()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(_index == 0 ? "Investidor" : "StarTup"),
      ),
      body: listaChidrenCadastro[_index],
      bottomNavigationBar: TitledBottomNavigationBar(
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Colors.black,
          indicatorColor: Theme.of(context).accentColor,
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          items: [
            TitledNavigationBarItem(
                title: Text('Investidor'), icon: Icons.person),
            TitledNavigationBarItem(
                title: Text('StarTup'), icon: Icons.emoji_objects),
          ]),
    );
  }
}
