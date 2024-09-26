import 'package:flutter/material.dart';
import 'package:shapefactory/conta.dart';
import 'package:shapefactory/home.dart';
import 'package:shapefactory/relatorio.dart';

class CentralPage extends StatefulWidget {
  const CentralPage({super.key});

  @override
  State<StatefulWidget> createState() => CentralPageState();
}

class CentralPageState extends State<CentralPage> {
  static List<Widget> _pages = <Widget>[Home(), Relatorio(), Conta()]; // Remover 'const'
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex), // New
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.article_rounded), label: "Relatório"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Conta"),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}







