import 'package:flutter/material.dart';
import 'package:shapefactoryforadms/AddExercise.dart';
import 'package:shapefactoryforadms/EditTraining.dart';

class CentralPage extends StatefulWidget {
  final dynamic musculos;

    const CentralPage({required this.musculos, super.key});


  @override
  State<StatefulWidget> createState() => CentralPageState();
}

class CentralPageState extends State<CentralPage> {

  var _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[AddExercise(widget.musculos), const EditTraining()];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: pages.elementAt(_selectedIndex), //New
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
