import 'package:flutter/material.dart';
import 'package:shapefactory/conta.dart';
import 'package:shapefactory/home.dart';
import 'package:shapefactory/relatorio.dart';

class CentralPage extends StatefulWidget {
  final int clientId;
  const CentralPage({required this.clientId,super.key});

  @override
  State<StatefulWidget> createState() => CentralPageState();
}

class CentralPageState extends State<CentralPage> {
  late List<Widget> _pages;
  var _selectedIndex = 0;


@override
  void initState() {
    _pages = <Widget>[Home(clientId: widget.clientId), const Relatorio(), Conta()]; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.clientId);
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







