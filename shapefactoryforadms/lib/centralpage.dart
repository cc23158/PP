import 'package:flutter/material.dart';
import 'package:shapefactoryforadms/AddExercice.dart';
import 'package:shapefactoryforadms/EditTraining.dart';

class CentralPage extends StatefulWidget {
  const CentralPage({super.key});

  @override
  State<StatefulWidget> createState() => CentralPageState();
}

class CentralPageState extends State<CentralPage> {
  static const List<Widget> _pages = <Widget>[AddExercice(), EditTraining()];
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Adicionar Exercício"),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), label: "Editar Treino"),
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
